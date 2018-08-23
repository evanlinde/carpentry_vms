#!/bin/bash

# Get variables from common settings file
source settings.sh

# Install R stuff via yum
# This takes much longer than installing via conda since additional 
# packages (e.g. tidyverse) are built from source when installed
# via R's "install.packages()" function. However it saves a lot of
# disk space (almost 5 GB).

# Install R and extra dependencies for building tidyverse
yum -y install R libcurl-devel openssl-devel libxml2-devel

# Install R packages
#R -e "install.packages('RSQLite',repo='http://cran.rstudio.com/')"
R -e "install.packages('tidyverse',repo='http://cran.rstudio.com/')"

# Install RStudio
wget ${rstudio_rpm_url}
yum -y install ${rstudio_rpm_file}

# Copy icon for rstudio to /opt (for setting up shortcuts)
rstudio_icon=$(rpm -q --filesbypkg rstudio | grep 'rstudio.png' | head -n 1)
cp ${rstudio_icon} /opt/rstudio.png

