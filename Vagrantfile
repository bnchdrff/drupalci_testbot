# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision :shell, :path => "provision.sh"
  config.vm.network :private_network, ip: "192.168.42.42"
  config.vm.synced_folder ".", "/home/vagrant/drupalci_testbot"
  config.vm.define "testbot" do |testbot|
      testbot.vm.provider "virtualbox" do |v|
        v.customize [ "modifyvm", :id, "--cpus", "4" ]
        v.customize [ "modifyvm", :id, "--memory", "4096" ]
        v.customize [ "modifyvm", :id, "--natdnshostresolver1", "on" ]
      end
  end
end
