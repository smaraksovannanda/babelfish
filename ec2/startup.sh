#!/bin/bash
sudo su
yum update -y
yum install httpd -y
cd /var/www/html
echo " Webserver-1-singapore using Terraform " > index.html
service httpd start
chkconfig httpd on


