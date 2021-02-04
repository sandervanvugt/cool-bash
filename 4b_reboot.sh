cat << REBOOT > /usr/local/completeme.sh
#!/bin/bash
echo DONE > /tmp/after-reboot
systemctl disable completeme
REBOOT
 
chmod +x /usr/local/completeme.sh
 
cat << SERVICE > /etc/systemd/system/completeme.service
[Unit]
Description=CompleteMe
 
[Install]
WantedBy=multi-user.target
 
[Service]
Type=simple
WorkingDirectory=/usr/local
ExecStart=/usr/local/completeme.sh
SERVICE
 
systemctl daemon-reload
systemctl enable completeme
 
reboot
