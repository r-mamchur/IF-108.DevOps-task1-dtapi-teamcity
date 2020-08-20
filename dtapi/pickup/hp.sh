#!/bin/bash

# Haproxy as balanser for D-tester

#yum update -y
yum install -y mc
yum install socat -y

yum install -y haproxy

systemctl start haproxy.service
systemctl enable haproxy.service

openssl req -newkey rsa:1024 -nodes -keyout /etc/haproxy/server.key \
-out /etc/haproxy/server.crt -x509 -days 365 \
-subj "/C=UA/ST=Prykarpattia/L=Ivano-Frankivsk/O=softserve.academy/OU=IF-108.DevOps/CN=192.168.56.21/emailAddress=r_mamchur@ukr.net"

cat /etc/haproxy/server.key > /etc/haproxy/server.pem
cat /etc/haproxy/server.crt >> /etc/haproxy/server.pem

yes|cp -f /vagrant/haproxy.cfg /etc/haproxy/ 

systemctl restart haproxy.service

