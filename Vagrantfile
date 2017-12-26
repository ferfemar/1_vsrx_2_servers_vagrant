# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "srv1" do |srv|
    srv.vm.box = "maier/alpine-3.6-x86_64"
    srv.vm.synced_folder ".", "/vagrant", disabled: true
    srv.vm.network "private_network", ip: "10.10.10.2",
      netmask: "255.255.255.0", virtualbox__intnet: "srv_net1"
    srv.vm.provision "file", source: "configs/srv1.sh", destination: "/home/vagrant/srv1.sh"
    srv.vm.provision "shell", inline: "sudo /bin/bash /home/vagrant/srv1.sh"
  end

  config.vm.define "vsrx1" do |srx|
    srx.vm.box = "juniper/ffp-12.1X47-D15.4" 
    srx.vm.synced_folder ".", "/vagrant", disabled: true
    srx.vm.network "private_network", ip: "10.10.10.1", nic_type: 'virtio', virtualbox__intnet: "srv_net1"
    srx.vm.network "private_network", ip: "10.20.20.1", nic_type: 'virtio', virtualbox__intnet: "srv_net2" 
    srx.vm.provider "virtualbox" do |v|
     v.check_guest_additions = false
    end

    srx.vm.provision "file", source: "configs/initial.cfg", destination: "/cf/root/initial.cfg"
    srx.vm.provision :host_shell do |host_shell|
     host_shell.inline = 'vagrant ssh vsrx1 -c "/usr/sbin/cli -f /cf/root/initial.cfg"'
    end
  end

  config.vm.define "srv2" do |srv|
    srv.vm.box = "maier/alpine-3.6-x86_64"
    srv.vm.synced_folder ".", "/vagrant", disabled: true
    srv.vm.network "private_network", ip: "10.20.20.2", 
     netmask: "255.255.255.0", virtualbox__intnet: "srv_net2"
    srv.vm.provision "file", source: "configs/srv2.sh", destination: "/home/vagrant/srv2.sh"
    srv.vm.provision "shell", inline: "sudo /bin/bash /home/vagrant/srv2.sh"
  end

end
