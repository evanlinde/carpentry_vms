#!/bin/bash


# Download files for the Ecology lessons
LESSON="dc-ecology"
cd ~/Desktop
[ -d "${LESSON}" ] && rm -rf "${LESSON}"
mkdir "${LESSON}"
cd "${LESSON}"
wget -O 1314459.zip https://ndownloader.figshare.com/articles/1314459/versions/6
unzip 1314459.zip


