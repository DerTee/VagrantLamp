# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "768"
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  config.push.define "atlas" do |push|
     push.app = "particle/lamp"
  end

  config.vm.provision "shell", inline: <<-SCRIPT
    apt-get update
    apt-get install -y puppet
    
    puppet module install puppetlabs-apache
    puppet module install puppetlabs-mysql --version 3.10.0
    puppet module install mayflower-php --version 4.0.0-beta1
  SCRIPT

  config.vm.provision "puppet", run: "always"
end

# sudo puppet apply --verbose /vagrant/manifests/default.pp
