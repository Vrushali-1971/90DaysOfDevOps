## Day 08 - Cloud Server Setup: Docker, Nginx and Web Deployment

## Today's goal is to deploy a real web server on the cloud and learn practical server management.

## Overview
Today I deployed a cloud web server using an EC2 instance.
I connected via SSH, Installed Nginx and Docker, configured security groups, and verified the web page
from a browser using the public IP

## Commands Used 

## 1. Connecting and Updating
## SSH into the instance
ssh -i "my-key.pem" ubuntu@<my-instance-ip>

## Update system packages
sudo apt update

## 2. Installing Nginx and Docker
## Install Nginx
sudo apt install nginx -y

## Check status 
systemctl status nginx

## Install Docker
sudo apt install docker.io -y

## check status 
systemctl status docker

## 3. Managing Logs
## View Live Nginx Logs
sudo tail -f /var/log/nginx/access.log

## Save logs to File
sudo tail -n 100 /var/log/nginx/access.log > nginx-logs.txt

## Download Log File to Your Local Machine
scp -i your-key.pem ubuntu<your-instance-ip>:home/ubuntu/nginx-logs.txt

## SSH Connection
Description: Successful terminal session into the AWS EC2 instance

## Nginx Welcome Page
Description: Webpage accessed via Public Ip address on port 80.

## Challenges Faced 
## Security Group Lockout:
  Initially, I coundn't access tha Nginx page
  Solution - I realized Port 80 was not open in the AWS Security Group. I added an Inbound Rule for HTTP(Port 80)
  from "Anywhere (0.0.0.0/0)

## SSH Connection Timeout : 
   Faced SSH connection timeout after mistakenly modifying the SSH inbound rule while adding HTTP (port 80)
   access for nginx, which removed SSH (port 22) access.
   solution - Removed the issue by correctly adding a separate inbound rule for SSH S(port 22) in the security group.

## What I Learned
How to deploy and access a web server (nginx) on an AWS EC2 instance.

Security Groups work on a per-port basis, and each service ( SSH and HTTP) requires its own inbound rules.

Modifying or removing the SSH (port 22) rule can immediately block remote access to the server.

How to install nginx and docker and verify a running service using systemctl.

How to view, monitor, save and download nginx access logs for troubleshooting.

## Why This Matters in Devops
Helps in provisioning and configuring cloud servers in real-world environments.

Builds hands-on experience with remote server management using SSH. 

Teaches how to deploy and manage services like Nginx.

Develops the skill of accessing and analyzing logs for troubleshooting. 

Improves understanding of security by configuring firewalls and security grops.




   




