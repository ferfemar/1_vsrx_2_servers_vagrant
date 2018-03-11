# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.define "srv1" do |srv|
    srv.vm.box = "maier/alpine-3.6-x86_64"
    srv.vm.synced_folder ".", "/vagrant", disabled: true
    srv.vm.network "private_network", ip: "10.10.10.2",
      netmask: "255.255.255.0", virtualbox__intnet: "srv_net1"
    srv.vm.provision "file", source: "configs/srv1.sh", destination: "/home/vagrant/srv1.sh"
    srv.vm.provision "shell", inline: "sudo /bin/bash /home/vagrant/srv1.sh"
    srv.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

  config.vm.define "vsrx1" do |srx|
    # Juniper provided public box is used
    srx.vm.box = "juniper/ffp-12.1X47-D15.4"
    # No sense in using synced folders with vsrx  
    srx.vm.synced_folder ".", "/vagrant", disabled: true
    # Configuration of network adapters - junos.vagrant plugin also auto configures the device
    srx.vm.network "private_network", ip: "10.10.10.1", nic_type: 'virtio', virtualbox__intnet: "srv_net1"
    srx.vm.network "private_network", ip: "10.20.20.1", nic_type: 'virtio', virtualbox__intnet: "srv_net2" 
    # Disable vbox additions
    srx.vm.provider "virtualbox" do |v|
     v.check_guest_additions = false
    end
    # Tune RAM allocated for the VM - 512 is a minimum and may cause problems, default is 2048
    srx.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--memory", "512"]
    end


    srx.vm.provision "file", source: "configs/initial.cfg", destination: "/cf/root/initial.cfg"
    srx.vm.provision :host_shell do |host_shell|
     host_shell.inline = "vagrant ssh vsrx1 -c 'cli -f /cf/root/initial.cfg'"
    end
  end

  config.vm.define "srv2" do |srv|
    srv.vm.box = "maier/alpine-3.6-x86_64"
    srv.vm.synced_folder ".", "/vagrant", disabled: true
    srv.vm.network "private_network", ip: "10.20.20.2", 
     netmask: "255.255.255.0", virtualbox__intnet: "srv_net2"
    srv.vm.provision "file", source: "configs/srv2.sh", destination: "/home/vagrant/srv2.sh"
    srv.vm.provision "shell", inline: "sudo /bin/bash /home/vagrant/srv2.sh"
    srv.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--memory", "256"]
    end
  end

end
