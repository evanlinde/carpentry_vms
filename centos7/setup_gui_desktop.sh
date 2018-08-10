#!/bin/bash

# Setup a very basic desktop built around IceWM
# The EPEL repo needs to be enabled

# Get variables from common settings file
source settings.sh

yum -y groups install x11
yum -y install firefox xterm xfce4-terminal icewm* pcmanfm-qt xarchiver geany gnome-icon-theme-legacy


# Set the default firefox homepage
sed -i "s~file:///usr/share/doc/HTML/index.html~${homepage_url}~" /usr/lib64/firefox/defaults/preferences/all-redhat.js


# Copy the wallpaper image to an accessible location
cp ${wallpaper_img} /opt/


# Setup the .xsession file in the skeleton directory (where it will be copied to new user profiles when they are created)
# This file tells xrdp to what GUI to start when users log in
cat << EOF_XSESSION > /etc/skel/.xsession
# Need to unset DBUS_SESSION_BUS_ADDRESS so that pcmanfm-qt will be able
# to start *within the xrdp session*. (It will be set again later anyway.)
unset DBUS_SESSION_BUS_ADDRESS
icewm-session
EOF_XSESSION
chmod +x /etc/skel/.xsession


# Create default settings for IceWM
mkdir -p /etc/skel/.icewm

# Automatically start pcmanfm-qt (provides desktop icons)
cat << EOF_ICEWM_STARTUP > /etc/skel/.icewm/startup
icewm-xdg-menu --entire-menu --with-theme-paths --icon-size 16 --theme gnome > ~/.icewm/programs.autogen
pcmanfm-qt --desktop --set-wallpaper=/opt/${wallpaper_img} --wallpaper-mode=fit
EOF_ICEWM_STARTUP

chmod +x /etc/skel/.icewm/startup

# General stuff that belongs in the "preferences" file
cat << EOF_ICEWM_PREFERENCES > /etc/skel/.icewm/preferences
# Use this command for logout since IceWM's default logout action doesn't
# work correctly when pcmanfm-qt is running as the desktop manager.
LogoutCommand="pkill -u \$USER"
EOF_ICEWM_PREFERENCES

# Add shortcut icons for the terminal and web browser to the toolbar
cat << EOF_ICEWM_TOOLBAR > /etc/skel/.icewm/toolbar
prog Terminal /usr/share/icons/gnome/16x16/apps/terminal.png xfce4-terminal
prog "Web browser" /usr/share/icons/gnome/16x16/apps/web-browser.png firefox ${homepage_url}
EOF_ICEWM_TOOLBAR

# Setup the "start" menu with icons for all the programs we'll need
cat << EOF_ICEWM_MENU > /etc/skel/.icewm/menu
prog Terminal /usr/share/icons/gnome/16x16/apps/terminal.png xfce4-terminal
prog "Web browser" /usr/share/icons/gnome/16x16/apps/web-browser.png firefox ${homepage_url}
prog "File manager" /usr/share/icons/gnome/16x16/apps/file-manager.png pcmanfm-qt
prog "Text editor" /usr/share/icons/gnome/16x16/apps/text-editor.png geany
separator
prog "Rebuild program menu" /usr/share/icons/gnome/16x16/actions/edit-find-replace.png /usr/share/icewm/startup
separator
menufile Programs folder programs.autogen
EOF_ICEWM_MENU


# Set default programs / mime types
mkdir -p /etc/skel/.config
cat << EOF_MIMEAPPS > /etc/skel/.config/mimeapps.list
[Added Associations]
x-scheme-handler/http=firefox.desktop
x-scheme-handler/https=firefox.desktop
application/zip=xarchiver.desktop;

[Default Applications]
application/zip=xarchiver.desktop
EOF_MIMEAPPS

mkdir -p /etc/skel/.config/xfce4
cat << EOF_XFCE_MIME > /etc/skel/.config/xfce4/helpers.rc
WebBrowser=firefox
EOF_XFCE_MIME




