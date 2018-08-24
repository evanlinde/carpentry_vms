#!/bin/bash

#
# Configure a fresh Lubuntu 16.04 installation for Software Carpentry
# Also includes software needed for the Ecology lessons in Data Carpentry
#

# Remove the GUI update manager so it doesn't prompt for updates
sudo apt-get -y remove update-manager-core python3-distupgrade python3-update-manager ubuntu-release-upgrader-core

# Install updates
sudo apt-get -y update
sudo apt-get -y dist-upgrade

# Define an array with the names of all the packages to be installed
# by apt-get. The array ends with the closing parenthesis. And blank
# lines and comments inside the array definition don't cause trouble.
declare -a apt_packages=(
# text editors
nano vim emacs

# web browsers
chromium-browser firefox

# R and related dependencies
r-base r-base-dev r-cran-plyr r-cran-reshape2 r-cran-ggplot2 libcurl4-gnutls-dev libxml2-dev r-cran-xml

# version control
git mercurial subversion

# more software development tools
gcc make

# sqlite
sqlite3

# virtualbox guest additions
virtualbox-guest-dkms

# additional system tools needed by shell-transcript
gawk xterm

# requirements for installing the R kernel in jupyter
libzmq-dev libssl-dev

# Additional things for Data Carpentry
libreoffice
default-jre  # for OpenRefine
)
# End of the apt package array.

# Install the apt packages
sudo apt-get -y install ${apt_packages[@]}


# Install programming tools and dependencies for VirtualBox guest additions
# dkms?

# Get the URL for the latest RStudio (32-bit) package from https://www.rstudio.com/products/rstudio/download/
wget https://download1.rstudio.org/rstudio-1.0.143-i386.deb
sudo gdebi -n rstudio-1.0.143-i386.deb
rm rstudio-1.0.143-i386.deb
# Fix font issue in RStudio
mkdir -p "${HOME}/.config/RStudio"
cat << R_EOF > "${HOME}/.config/RStudio/desktop.ini"
[General]
font.fixedWidth=FreeMono
R_EOF


# Get the URL for the latest Anaconda3 (32-bit) package from https://www.continuum.io/downloads
wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86.sh
bash Anaconda3-4.4.0-Linux-x86.sh -b -p "${HOME}/anaconda3"
rm Anaconda3-4.4.0-Linux-x86.sh
echo -e '\nexport PATH=${HOME}/anaconda3/bin:$PATH' >> "${HOME}/.bashrc"


# Install IRKernel
# This allows you to use R in jupyter notebooks
# Steps from https://irkernel.github.io/installation/
sudo R -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'), repos='http://cran.rstudio.com/')"
sudo R -e "devtools::install_github('IRkernel/IRkernel')"
# Just install the R kernel for the swc user since Anaconda is installed in swc's home
PATH=${HOME}/anaconda3/bin:$PATH R -e "IRkernel::installspec()"



# Install OpenRefine (for Data Carpentry)
# http://openrefine.org/download.html
wget  https://github.com/OpenRefine/OpenRefine/releases/download/2.7-rc.2/openrefine-linux-2.7-rc.2.tar.gz
tar -zxf openrefine-linux-2.7-rc.2.tar.gz -C "${HOME}"
rm openrefine-linux-2.7-rc.2.tar.gz



# Install sqlite firefox plugin (for Data Carpentry)
# https://addons.mozilla.org/en-US/firefox/addon/sqlite-manager/
extension_xpi="addon-5817-latest.xpi"
wget https://addons.mozilla.org/firefox/downloads/latest/sqlite-manager/${extension_xpi}
extension_id=$(unzip -p ${extension_xpi} install.rdf | sed -E -n '1,10{/<em:id>/{s:^.*>(.+)</.*$:\1:;p}}')
sudo mv ${extension_xpi} "/usr/lib/firefox-addons/extensions/${extension_id}.xpi"



# Install ggplot for python (for Data Carpentry)
PATH=${HOME}/anaconda3/bin:$PATH pip install ggplot



# Install tidyverse for R (for Data Carpentry)
sudo R -e "install.packages('tidyverse',repo='http://cran.rstudio.com/')"



# Use the system sqlite3 instead of anaconda sqlite3 
# because anaconda's version doesn't support up arrow
# (anaconda's version is compiled without readline support)
# \x27 is the escape sequence to produce the single-quote character
echo -e '\nalias sqlite3=\x27/usr/bin/sqlite3\x27' >> "${HOME}/.bashrc"



# Setup automatic login (user should be "swc")
T=$(mktemp)
cat << EOF_AUTOLOGIN > $T
[Seat:*]
autologin-user=${USER}
autologin-user-timeout=0
EOF_AUTOLOGIN
sudo mv $T /etc/lightdm/lightdm.conf.d/swc_autologin.conf



# Add shortcut for LXTerminal to desktop
cat << EOF_LXTerm > "${HOME}/Desktop/lxterminal.desktop"
[Desktop Entry]
Name=LXTerminal
TryExec=lxterminal
Exec=lxterminal
Icon=lxterminal
Type=Application
EOF_LXTerm



# Reboot when done
sudo reboot

