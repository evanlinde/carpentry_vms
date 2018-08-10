#!/bin/bash

# This file may be sourced by several scripts

# URL for the Anaconda installer
# Get the latest link from www.anaconda.com/downloads
anaconda_installer_url="https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh"

# Filename of the Anaconda installer
# (get rid of the last slash and everything before it from ${installer_url})
anaconda_installer_file="${anaconda_installer_url/*\/}"

# Directory where Anaconda should be installed
anaconda_installation_dir="/opt/anaconda3"

# Browser homepage
homepage_url="https://osu-carpentry.github.io/"

# Desktop background image
wallpaper_img="swc.png"


# Prefix for workshop user accounts
# Usernames will be this followed by a two-digit number
username_prefix="swc"
# Number of users to create
users=40

# URL for the guacamole war file
guacamole_war_url="http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/0.9.14/binary/guacamole-0.9.14.war"

# Filename of the guacamole war file
guacamole_war_file="${guacamole_war_url/*\/}"

# Name to use for guacamole app (relative to server root) in URL
# (e.g. use "guacamole" to have the app served at https://servername/guacamole)
# Don't use any slashes
guacamole_app_name="swc2018"

# Connection title -- appears in guacamole menu (Ctrl-Alt-Shift)
singlerdp_connection_title="Software Carpentry Workshop"

singlerdp_jar_url="https://github.com/evanlinde/guacamole-auth-singlerdp/raw/master/builds/guacamole-auth-singlerdp-0.9.14.jar"

singlerdp_jar_file="${singlerdp_jar_url/*\/}"

