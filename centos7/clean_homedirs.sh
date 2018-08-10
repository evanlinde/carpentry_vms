#!/bin/bash

# Clean the workshop user home directories (delete and re-create them)

# Get variables from common settings file
source settings.sh

# Delete and re-create home directories for workshop accounts
for ((i=1; i<=${users}; i++)); do
    # Format the numbers with leading zeros (i.e. 01, 02, etc.)
    num=$(printf "%02d" ${i})
    user_name="${username_prefix}${num}"
    user_home=$(getent passwd ${user_name} | cut -d: -f6)
    rm -rf ${user_home}
    /sbin/mkhomedir_helper ${user_name} 0077 /etc/skel
done

