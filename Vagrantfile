# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  chunk_and_id = '971'
  vagrant_domain = 'training.local'
  if ENV['ENVIRONMENT_TYPE'] == 'PROD'
    setting_environment = 'p'
    vagrant_domain = 'production.local'
  else
    setting_environment = 'training'
  end

 puts "Building environment: #{setting_environment}"

  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    vb.gui = false

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

  config.vm.box = "centos6.6"
  config.vm.box_url = "https://github.com/tommy-muehle/puppet-vagrant-boxes/releases/download/1.0.0/centos-6.6-x86_64.box"

  config.vm.define :www do |x|
    x.vm.hostname = "#{setting_environment}-www-#{chunk_and_id}.#{vagrant_domain}"
    if #{setting_environment} == 'p'
      x.vm.network :private_network,ip: "10.211.55.226", :netmask => "255.255.255.0"
    else
      x.vm.network :private_network,ip: "10.211.55.225", :netmask => "255.255.255.0"
    end
    x.vm.network :forwarded_port, guest: 8080, host: 8088
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--memory", "1048"]
    end
  end

  config.vm.define :staticcontent do |x|
    x.vm.hostname = "#{setting_environment}-staticcontent-#{chunk_and_id}.#{vagrant_domain}"
    if #{setting_environment} == 'p'
      x.vm.network :private_network,ip: "10.211.55.227", :netmask => "255.255.255.0"
    else
      x.vm.network :private_network,ip: "10.211.55.228", :netmask => "255.255.255.0"
    end    
    x.vm.network :forwarded_port, guest: 80, host: 8081
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--memory", "1048"]
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = [ "modules" ]
    puppet.working_directory = "/vagrant"
    puppet.options = '--hiera_config=/vagrant/hiera.yaml -v'
    puppet.facter = {
      "vagrant" => "1"
    }
  end
 
end
