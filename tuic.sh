#!/bin/bash

mkdir /opt/tuic && cd /opt/tuic
wget https://github.com/EAimTY/tuic/releases/download/0.8.5/tuic-server-0.8.5-x86_64-linux-gnu
chmod +x tuic-server-0.8.5-x86_64-linux-gnu

cat > tuic.json <<-EOF
{
    "port": 8443,
    "token": ["999999999"],
    "certificate": "/opt/tuic/fullchain.pem",
    "private_key": "/opt/tuic/privkey.pem",
    "ip": "::",
    "congestion_controller": "bbr",
    "alpn": ["h3"]
}
EOF


cat > /lib/systemd/system/tuic.service <<-EOF
[Unit]
Description=Delicately-TUICed high-performance proxy built on top of the QUIC protocol
Documentation=https://github.com/EAimTY/tuic
After=network.target

[Service]
User=root
WorkingDirectory=/opt/tuic
ExecStart=/opt/tuic/tuic-server-0.8.5-x86_64-linux-gnu -c config.json
Restart=on-failure
RestartPreventExitStatus=1
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

apt install socat

curl  https://get.acme.sh | sh -s email= 123456@qq.com

#~/.acme.sh/acme.sh --install-cert -d yourdomain.com
#--fullchain-file    /opt/tuic/fullchain.pem    \
#--key-file       /opt/tuic/privkey.pem  \

#systemctl enable --now tuic.service
