#!/bin/bash

#yum update -y
yum install -y mc
yum install -y wget
yum install -y unzip

yum install -y mysql-server
systemctl start mysqld.service
systemctl enable mysqld.service

echo "CREATE DATABASE dtapi DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; " | mysql
echo "CREATE USER 'dtapi'@'%' IDENTIFIED BY 'Passw0rd('; " | mysql
echo "GRANT ALL ON dtapi.* TO 'dtapi'@'%' WITH GRANT OPTION; " | mysql

/bin/wget https://dtapi.if.ua/~yurkovskiy/dtapi_full.sql

mysql -Ddtapi  < ./dtapi_full.sql

echo "CREATE TABLE sessions ( 
    session_id varchar(32) NOT NULL, 
    last_active int(10) unsigned NOT NULL, 
    contents text NOT NULL, 
    PRIMARY KEY (session_id)) 
    ENGINE=MyISAM DEFAULT CHARSET=utf8; " | mysql -Ddtapi

echo "RENAME TABLE dtapi.groups TO dt_groups; " | mysql -Ddtapi



#echo "bind-address = 0.0.0.0" >>/etc/my.cnf
