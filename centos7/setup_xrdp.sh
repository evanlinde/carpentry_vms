#!/bin/bash

# Install xrdp (available in EPEL)
yum -y install xrdp

# Comment out the Xvnc section so that only Xorg backend is available
grep -q '^\[Xorg\]*$' /etc/xrdp/xrdp.ini && sed -i '/^\[Xvnc\]/,/^\ *$/s/^/\#/g' /etc/xrdp/xrdp.ini

# Allow incoming RDP connections
firewall-cmd --permanent --add-port=3389/tcp
firewall-cmd --reload

# Enable and start the RDP server
systemctl enable xrdp
systemctl start xrdp
