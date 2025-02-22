#!/bin/bash

USERNAME=skhan

# Install the service
cp backup_script.sh /home/$USERNAME/bin/
sudo chmod +x /home/$USERNAME/bin/home_backup.sh
cp home_backup.service /etc/systemd/system/
systemctl enable sync_home.service
systemctl start sync_home.service

sudo systemctl daemon-reload
sudo systemctl status home_backup.service

sudo tail -f /var/log/home_backup.log  # To follow the log in real-time

sudo crontab -e
# 0 * * * * systemctl start home_backup.service