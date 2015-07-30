#!/bin/sh

work() {
    sed -i -e 's/archive.ubuntu.com/jp.archive.ubuntu.com/' /etc/apt/sources.list

    apt-get update
    apt-get -y dist-upgrade

    apt-get -y install unzip

    cd /tmp
    wget https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip
    unzip 0.5.2_linux_amd64.zip
    mv consul /usr/bin
}

work > /tmp/boot.log 2>&1 &
