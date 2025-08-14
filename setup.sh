#!/bin/bash

# The claim token and room ID are stored in a simple file called conf (config). This file is in the .gitignore since I do not want to push them to a public repo.
# Claim token and room ID can be found in your Netdata settings (online)

# Infos to add node to dashboard
claimToken=$(grep 'CLAIM_TOKEN' ./conf |  awk -F'=' '{print $2}')
roomID=$(grep 'ROOM_ID' ./conf |  awk -F'=' '{print $2}')

# Netdata Linux Installation && Adding Node to dashboard
echo -e "Netdata Install\n"
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --stable-channel --claim-token "$claimToken" --claim-rooms "$roomID" --claim-url https://app.netdata.cloud

# Install stress-ng
echo -e "\nInstalling stress-ng\n"
sudo apt install -y stress-ng

# Prepare cpu.conf
cpu_conf="/opt/netdata/etc/netdata/health.d/cpu.conf"
sudo mkdir -p /opt/netdata/etc/netdata/health.d
sudo cp ./cpu.conf "$cpu_conf"

# Restart Netdata
sudo service netdata restart

# Make scripts executable
chmod +x ./stress_test.sh ./cleanup.sh
