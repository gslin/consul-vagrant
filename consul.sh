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
}

work > /tmp/boot.log 2>&1 &
