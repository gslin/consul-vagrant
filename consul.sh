#!/bin/sh

work() {
    sed -i -e 's/archive.ubuntu.com/tw.archive.ubuntu.com/' /etc/apt/sources.list

    cd /tmp
    wget https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip &

    apt-get -Vy update
    apt-get -Vy install unzip

    wait
    unzip consul_0.6.3_linux_amd64.zip
    mv consul /usr/bin

    local IP
    IP=$(ifconfig eth1 | grep -E -o '192\.168\.50\.10[0-9]')

    mkdir /etc/consul.d

    cat > /etc/consul.d/config.json <<EOF
{
    "data_dir": "/tmp/consul",
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

    cat > /etc/consul.d/googledns.json <<EOF
{
    "services": [
        {
            "id": "googledns",
            "name": "googledns",
            "tags": ["master"],
            "address": "8.8.8.8",
            "port": 53,
            "checks": [
                {
                    "script": "/usr/bin/host www.google.com 8.8.8.8",
                    "interval": "5s"
                }
            ]
        }
    ]
}
EOF

    if [ "x${IP}" = "x192.168.50.103" ]; then
        consul agent -bootstrap-expect 1 -config-dir /etc/consul.d -bind="${IP}" &
    else
        consul agent -config-dir /etc/consul.d -bind="${IP}" &
    fi

    sleep 1
    consul join 192.168.50.101 || true
    consul join 192.168.50.102 || true
    consul join 192.168.50.103 || true
}

work > /tmp/boot.log 2>&1 &
