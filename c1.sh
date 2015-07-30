#!/bin/sh

work() {
    sed -i -e 's/archive.ubuntu.com/jp.archive.ubuntu.com/' /etc/apt/sources.list

    apt-get update
    apt-get -y dist-upgrade
}

work > /tmp/boot.log 2>&1 &
