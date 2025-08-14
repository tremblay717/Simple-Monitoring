#!/bin/bash

echo "Keys available"
ls -l ~/.ssh

# Private key to authenticate
read -p "Enter the name of your private key:" privateKey

ipAddress=$(grep 'REMOTE_IP' ./conf | awk -F'=' '{print $2}')
remotePath=$(grep 'REMOTE_PATH' ./conf | awk -F'=' '{print $2}')
userName=$(grep 'REMOTE_USER' ./conf | awk -F'=' '{print $2}')
localPath=$(pwd)

echo "Private Key Name: ${privateKey}"
echo "Local Path: ${localPath}"
echo "Remote IP: ${ipAddress}"
echo "Remote Destination: ${remotePath}"

# rsync command
rsync -avz -e "ssh -i ~/.ssh/${privateKey}"  ${localPath} ${userName}@${ipAddress}:${remotePath}