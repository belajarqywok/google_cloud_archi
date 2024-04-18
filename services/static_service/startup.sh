#!/bin/bash
apt-get update
apt-get install -y wget
rm -f gce_config.sh
wget -O gce_config.sh https://gist.githubusercontent.com/belajarqywok/8883c83199a0f50e386c407d691fdb78/raw/46085b3d27541534a9212d4e283cddf058d4befc/gce_config.sh
if [ $? -eq 0 ]; then
    chmod +x gce_config.sh
    ./gce_config.sh
else
    echo "Failed to download gce_config.sh script. Exiting."
    exit 1
fi