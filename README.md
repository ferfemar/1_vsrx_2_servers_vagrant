Simple vSRX w/ two servers topology
===================================

A Vagrant topology using official Juniper vSRX image and two Alpine Linux servers for testing.

Topology
========
```
   eth0  +-------------+
 +-------+     SRV1    | Static routing for SRV2
  to host|             |
         +-------------+
               .2| 10.10.10.0/24
               .1|
ge-0/0/0 +-------------+
 +-------+     VSRX1   |
  to host|             |
         +-------------+
               .1| 10.20.20.0/24
               .2|
   eth0  +-------------+
 +-------+     SRV2    | Static routing for SRV1
  to host|             |
         +-------------+
```

Requirements
============

Vagrant w/ plugins: junos-vagrant, alpine-vagrant
Virtualbox

Usage
=====

Clone the distro 

```
git clone https://github.com/ferfemar/1_vsrx_2_servers_vagrant.git
```

Run the topology

```
vagrant up
```

Connect to devices

```
vagrant ssh srv1
vagrant ssh srv2
vagrant ssh vsrx1
```
