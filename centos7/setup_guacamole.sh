#!/bin/bash

# Get variables from common settings file
source settings.sh

# Install tomcat and the libguac daemon
yum -y install tomcat guacd libguac libguac-client-rdp

# Download the guacamole web app and set it up to be deployed by tomcat
curl -L "${guacamole_war_url}" > ${guacamole_war_file}
cp ${guacamole_war_file} /usr/share/tomcat/webapps/

# Install the singlerdp extension
mkdir -p /usr/share/tomcat/.guacamole/extensions
wget ${singlerdp_jar_url}
cp ${singlerdp_jar_file} /usr/share/tomcat/.guacamole/extensions

# Settings for the singlerdp extension
cat <<- EOF > /usr/share/tomcat/.guacamole/guacamole.properties
singlerdp-title=${singlerdp_connection_title}
singlerdp-hostname=127.0.0.1
singlerdp-port=3389
EOF

# Enable and start the guacd service
systemctl enable guacd
systemctl start guacd

# Enable and start tomcat
systemctl enable tomcat
systemctl start tomcat

# Create a symlink to the guacamole app with the name we want to use
pushd /usr/share/tomcat/webapps
default_app_name=${guacamole_war_file/.war/}
ln -s ${default_app_name} ${guacamole_app_name}
popd


