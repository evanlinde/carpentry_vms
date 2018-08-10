#!/bin/bash

# Create workshop users (e.g. swc01, swc02, etc.) with 
# passwords set to their usernames.
# Also use cgroups to limit user memory consumption.

# Get variables from common settings file
source settings.sh

for ((i=1; i<=${users}; i++)); do
    # Format the numbers with leading zeros (i.e. 01, 02, etc.)
    num=$(printf "%02d" ${i}) 
    user_name="${username_prefix}${num}"
    useradd -u 20${num} -m -p $(echo "${user_name}" | openssl passwd -1 -stdin) ${user_name}; 
    cat <<- CGEOF > /etc/systemd/system/user-20${num}.slice
	[Unit]
	Description=20${num}
	
	[Slice]
	MemoryAccounting=true
	MemoryLimit=1000M
	#CPUQuota=25%
	CGEOF
done
systemctl daemon-reload
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/resource_management_guide/sec-modifying_control_groups
# https://stackoverflow.com/questions/47367886/cgroup-configuration-in-centos-7

