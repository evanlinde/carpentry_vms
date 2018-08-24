#!/bin/bash

#
# Configure a fresh Lubuntu 18.04 installation for Software Carpentry
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
r-base r-base-dev r-cran-devtools r-cran-gridextra r-cran-hexbin r-cran-knitr r-cran-plyr r-cran-reshape2 r-cran-rsqlite libcurl4-gnutls-dev libxml2-dev r-cran-xml r-cran-dplyr r-cran-forcats r-cran-ggplot2 r-cran-purrr r-cran-readr r-cran-stringr r-cran-tibble r-cran-tidyr r-cran-blob r-cran-broom r-cran-glue r-cran-haven r-cran-hms r-cran-httr r-cran-jsonlite r-cran-lubridate r-cran-magrittr r-cran-readxl r-cran-xml2

# Python stuff to avoid needing Anaconda
jupyter python3-ipykernel python3-jupyter-core python3-numpy python3-matplotlib python3-pandas

# version control
git mercurial

# more software development tools
gcc make

# sqlite
sqlite3 sqlitebrowser

# virtualbox guest additions
virtualbox-guest-dkms

# additional system tools needed by shell-transcript
gawk xterm

# requirements for installing the R kernel in jupyter
libzmq3-dev libssl-dev

# Additional things for Data Carpentry
libreoffice
default-jre  # for OpenRefine
)
# End of the apt package array.

# Install the apt packages
sudo apt-get -y install ${apt_packages[@]}


# Get the URL for the latest RStudio package from https://www.rstudio.com/products/rstudio/download/
rstudio_url="https://download1.rstudio.org/rstudio-xenial-1.1.456-amd64.deb"
rstudio_deb_file="${rstudio_url/*\/}"
wget ${rstudio_url}
sudo gdebi -n ${rstudio_deb_file}
rm ${rstudio_deb_file}
# Fix font issue in RStudio
mkdir -p "${HOME}/.config/RStudio"
cat << R_EOF > "${HOME}/.config/RStudio/desktop.ini"
[General]
font.fixedWidth=FreeMono
R_EOF


# Install IRKernel
# This allows you to use R in jupyter notebooks
# Steps from https://irkernel.github.io/installation/
sudo R -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'), repos='http://cran.rstudio.com/')"
sudo R -e "devtools::install_github('IRkernel/IRkernel')"
sudo R -e "IRkernel::installspec()"


# Install plotnine for python (for Data Carpentry)
sudo pip3 install plotnine


# Install additional R packages not provided by apt
# tidyverse and dbplyr for Data Carpentry
# roxygen2 for Software carpentry
sudo R -e "install.packages(c('tidyverse','dbplyr','roxygen2'),repo='http://cran.rstudio.com/')"


# Install OpenRefine (for Data Carpentry)
# http://openrefine.org/download.html
openrefine_url="https://github.com/OpenRefine/OpenRefine/releases/download/3.0-rc.1/openrefine-linux-3.0-rc.1.tar.gz"
openrefine_tar_file="${openrefile_url/*\/}"
wget ${openrefine_url}
tar -zxf ${openrefine_tar_file} -C "${HOME}"
rm ${openrefine_tar_file}



# Setup automatic login for the current user (user should be "swc")
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


# Fix any possible file ownership problems from all the sudo use
sudo chown -R ${USER}:$(id -gn ${USER}) "${HOME}"


# Reboot when done
sudo reboot

