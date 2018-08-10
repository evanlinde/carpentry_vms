#!/bin/bash

# Get variables from common settings file
source settings.sh

yum -y install httpd mod_ssl mod_proxy_html

# Set SELinux to allow reverse proxying
setsebool -P httpd_can_network_connect 1

# Enable reverse proxy config
cp /usr/share/doc/httpd-2.4.6/proxy-html.conf /etc/httpd/conf.d/

# Settings to reverse proxy to the guacamole app served by tomcat
cat <<- EOF > /etc/httpd/conf.d/reverse_proxy.conf
# Redirect to https
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^/(.*) https://%{SERVER_NAME}/\$1

Redirect "/${guacamole_app_name}" "/${guacamole_app_name}/"
<Location /${guacamole_app_name}/>
    ProxyPass http://127.0.0.1:8080/${guacamole_app_name}/ flushpackets=on
    ProxyPassReverse http://127.0.0.1:8080/${guacamole_app_name}/
    ProxyHTMLEnable On
    RequestHeader unset Accept-Encoding
</Location>
<Location /${guacamole_app_name}/websocket-tunnel>
    ProxyPass ws://127.0.0.1:8080/${guacamole_app_name}/websocket-tunnel
    ProxyPassReverse ws://127.0.0.1:8080/${guacamole_app_name}/websocket-tunnel
</Location>
EOF

# Create a self-signed certificate and key valid for 10 years (3650 days)
openssl req -batch -nodes -new -x509 -days 3650 -subj "/CN=$(hostname)" -keyout server.key -out server.crt

# Copy certificate and key files to system dir
cp server.crt /etc/pki/tls/certs/
cp server.key /etc/pki/tls/private/
chmod 600 /etc/pki/tls/private/server.key

# Configure apache to use the certificate and key that we generated
sed -i '/^ *SSLCertificateFile/s:/etc/pki/tls/certs/localhost.crt:/etc/pki/tls/certs/server.crt:' /etc/httpd/conf.d/ssl.conf
sed -i '/^ *SSLCertificateKeyFile/s:/etc/pki/tls/private/localhost.key:/etc/pki/tls/private/server.key:' /etc/httpd/conf.d/ssl.conf

# Exclude less secure SSL protocols
sed -i '/^ *SSLProtocol/s/\(SSLProtocol \).*$/\1all -SSLv2 -SSLv3 -TLSv1/' /etc/httpd/conf.d/ssl.conf

# Enable and start the apache service
systemctl enable httpd
systemctl start httpd

# Allow https through the firewall
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

