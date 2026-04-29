#!/bin/bash

# Update packages
sudo apt update -y

# Install required packages
sudo apt install unzip curl -y

# Download AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"

# Unzip
unzip /tmp/awscliv2.zip -d /tmp

# Install AWS CLI
sudo /tmp/aws/install

############################
# Jenkins Installation
############################
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java -version
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y

############################
# Terraform installation
############################
# sudo apt update && sudo apt upgrade -y
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform -y
terraform -version

##################################
# Copying Jenkins pass File to s3
##################################
sudo aws s3 cp /var/lib/jenkins/secrets/initialAdminPassword s3://${BucketName}/jenkins-pass.txt