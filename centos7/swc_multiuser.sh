#!/bin/bash
# Setup a multi-user CentOS 7 system for software carpentry workshops
bash setup_base.sh
bash setup_epel.sh
bash setup_anaconda.sh
bash setup_r_conda.sh  # Faster, but takes ~5GB more disk space
#bash setup_r_yum.sh    # Takes ~5GB less disk space but may take hours
bash setup_gui_desktop.sh
bash setup_xrdp.sh
bash create_users.sh
bash setup_guacamole.sh
bash setup_apache.sh

