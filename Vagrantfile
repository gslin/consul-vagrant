# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.define "consul1" do |c|
        c.vm.hostname = "consul1"
        c.vm.provision "shell", path: "consul.sh"
        c.vm.network "private_network", ip: "192.168.50.101"
    end

    config.vm.define "consul2" do |c|
        c.vm.hostname = "consul2"
        c.vm.provision "shell", path: "consul.sh"
        c.vm.network "private_network", ip: "192.168.50.102"
    end

    config.vm.define "consul3" do |c|
        c.vm.hostname = "consul3"
        c.vm.provision "shell", path: "consul.sh"
        c.vm.network "private_network", ip: "192.168.50.103"
    end
end
