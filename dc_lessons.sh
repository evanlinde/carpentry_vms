#!/bin/bash


# Download files for the Ecology lessons
LESSON="dc-ecology"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget -O 1314459.zip https://ndownloader.figshare.com/articles/1314459/versions/6
unzip 1314459.zip

# Download files for the Social Science lessons
LESSON="dc-socialsci"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget -O 6262019.zip https://ndownloader.figshare.com/articles/6262019/versions/4
unzip 6262019.zip
