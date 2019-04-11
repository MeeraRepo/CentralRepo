#!/bin/bash
sudo -E yum -y update
sudo -E yum -y install wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo  rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo -E yum -y update
sudo -E yum -y install mysql-server
sudo systemctl start mysqld
sleep 1s
mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('123') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF
