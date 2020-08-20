#!/bin/bash

echo 'pwd' $(pwd) >/vagrant/lll
echo 'id' $(id) >>/vagrant/lll
echo 'home' $HOME >>/vagrant/lll

#yum update -y
yum install -y mc
#yum install yum-utils -y
yum install -y wget
#yum install -y unzip
#yum install -y git
#yum install -y nano
yum install httpd -y
systemctl enable httpd

export PATH=/usr/local/bin:$PATH

cat <<EOF > /etc/httpd/conf.d/dtapi.conf
<VirtualHost *:80>
    DocumentRoot /var/www/dtapi
    ErrorLog /var/log/httpd/dtapi_error.log
    CustomLog /var/log/httpd/dtapi_requests.log combined
    <Directory /var/www/dtapi/>
            AllowOverride All
    </Directory>
</VirtualHost>
EOF

chown apache:apache /var/www/ -R
chmod 777 -R /var/www/

chcon -t httpd_sys_rw_content_t /var/www/dtapi -R
setsebool -P httpd_can_network_connect on
setsebool -P httpd_can_network_memcache on
setsebool -P httpd_can_network_connect_db on

systemctl restart httpd
 


