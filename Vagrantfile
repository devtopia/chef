# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.define :dev do |dev|
    dev.vm.box = "dev"
    dev.vm.hostname = "dev"
    dev.vm.network "forwarded_port", guest: 80, host: 8888
    dev.vm.network "private_network", ip: "192.168.33.10"
    dev.vm.provider "virtualbox" do |vb|
      vb.name = "dev"
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end

  config.vm.define :test do |test|
    test.vm.box = 'test'
    test.vm.hostname = 'test'
    test.vm.network :forwarded_port, guest: 80, host: 8889
    test.vm.network :private_network, ip: '192.168.33.11'
    test.vm.provider :virtualbox do |vb|
      vb.name = 'test'
      vb.customize ['modifyvm', :id, '--memory', '1024']
    end
  end
end
