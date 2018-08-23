#!/bin/bash

# Get variables from common settings file
source settings.sh

# Install R stuff via conda
PATH=${anaconda_installation_dir}/bin:$PATH
conda install -y r rstudio r-tidyverse

# Copy icon for rstudio to /opt (for setting up shortcuts)
rstudio_icon=$(find ${anaconda_installation_dir}/pkgs/rstudio-*/share/rstudio/ -maxdepth 1 -name 'rstudio.png')
cp ${rstudio_icon} /opt/rstudio.png

