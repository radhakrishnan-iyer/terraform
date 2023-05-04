#!/bin/bash
yum update -y
yum install -y httpd
echo "<h1>Hello From Terraform EC2</h1>" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd