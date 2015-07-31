Consul Vagrantfile
==================

Overview
--------

This <code>Vagrantfile</code> will install a Consul 0.5.2.

Tested on Vagrant 1.7.4 (w/ VirtualBox).

Configuration
-------------

Base system will be <code>ubuntu/trusty64</code>.

Network settings will be:

1. consul1 (eth1, 192.168.50.101)
2. consul2 (eth1, 192.168.50.102)
3. consul3 (eth1, 192.168.50.103)

eth0 will be NAT.

License
-------

http://opensource.org/licenses/BSD-3-Clause

2014, Gea-Suan Lin &lt;gslin@kkbox.com>, KKBOX.
