#!/bin/sh

work() {
    sed -i -e 's/archive.ubuntu.com/jp.archive.ubuntu.com/' /etc/apt/sources.list

    cd /tmp
    wget https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip &

    apt-get -Vy update
    apt-get -Vy install unzip

    wait
    unzip 0.5.2_linux_amd64.zip
    mv consul /usr/bin

    local IP
    IP=$(ifconfig eth1 | grep -E -o '192\.168\.50\.10[0-9]')

    mkdir /etc/consol.d
    cat > /etc/consol.d/config.json <<EOF
{
    "data_dir": "/tmp/consol",
    "domain": "consul.kkcorp.",
    "enable_syslog": true,
    "ports": {
        "dns": 53
    },
    "recursors": [
        "8.8.8.8"
    ],
    "server": true
}
EOF

    consul agent -config-dir /etc/consol.d -bind="${IP}" &
    sleep 1
    consul join 192.168.50.101 || true
    consul join 192.168.50.102 || true
    consul join 192.168.50.103 || true
}

work > /tmp/boot.log 2>&1 &
