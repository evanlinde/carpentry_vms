#!/bin/bash

# Get variables from common settings file
source settings.sh

# Install Anaconda (Python)
# Get anaconda link from www.anaconda.com/downloads
# Set the URL in settings.sh
wget "${anaconda_installer_url}"
bash ${anaconda_installer_file} -b -p ${anaconda_installation_dir}
echo echo \$PATH \| grep -q \"${anaconda_installation_dir}/bin:\" \|\| export PATH=${anaconda_installation_dir}/bin:\$PATH > /etc/profile.d/anaconda3.sh
rm -f ${installer_file}

# Install R stuff via conda
PATH=${anaconda_installation_dir}/bin:$PATH
conda install -y r rstudio r-tidyverse

# Copy icons for jupyter and rstudio to /opt (for setting up shortcuts)
rstudio_icon=$(find ${anaconda_installation_dir}/pkgs/rstudio-*/share/rstudio/ -maxdepth 1 -name 'rstudio.png')
cp ${rstudio_icon} /opt/rstudio.png
jupyter_icon=$(find ${anaconda_installation_dir}/pkgs/jupyterlab-*/info/ -maxdepth 1 -name 'icon.png')
cp ${jupyter_icon} /opt/jupyter.png

