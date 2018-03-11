# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.define "srv1" do |srv|
    # This box seems to be working the best with the vagrant-alpine plugin
    srv.vm.box = "maier/alpine-3.6-x86_64"
    # Don't need synced folder
    srv.vm.synced_folder ".", "/vagrant", disabled: true
    # Network settings, autoconfiguration is handeled by the vagrant-alpine plugin
    srv.vm.network "private_network", ip: "10.10.10.2",
      netmask: "255.255.255.0", virtualbox__intnet: "srv_net1"
    # Simple provision - copy a bash script over and run it
    srv.vm.provision "file", source: "configs/srv1.sh", destination: "/home/vagrant/srv1.sh"
    srv.vm.provision "shell", inline: "sudo /bin/bash /home/vagrant/srv1.sh"
    # Tune RAM allocated - 256MB is OK for this box.  
    srv.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--memory", "256"]
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

    #Copies the configuration file to the device filesystem
    srx.vm.provision "file", source: "configs/initial.cfg", destination: "/cf/root/initial.cfg"
    #Uses host_shell plugin to send command (to run the config file) over ssh to the SRX
    srx.vm.provision :host_shell do |host_shell|
     host_shell.inline = "vagrant ssh vsrx1 -c 'cli -f /cf/root/initial.cfg'"
    end
  end

end
