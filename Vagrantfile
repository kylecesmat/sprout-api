VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.7.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ## CONFIG START
  environment = ENV['APP_ENV'] || 'development'
  app_name = ENV['APP_NAME'] || 'sprout-app'
  app_subdomain = 'api'
  static_ip = ENV['STATIC_IP'] || '192.168.50.100'

  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision 'shell', path: './vagrant.config.sh', args: "#{environment}"
  # END CONFIG

  config.vm.hostname = app_subdomain + '.' + app_name + '.vm'
  config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ["acregmax=5"]
  config.vm.network 'private_network', ip: static_ip

  config.hostmanager.include_offline = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.manage_host = true
  config.hostmanager.aliases = [app_subdomain + '.' + app_name + '.vm']

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on', '--memory', '2048']
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "nodejs"
    chef.json = {
      "nodejs" => {
        "version" => "5.3.0",
	    "from_source" => true
      }
    }
  end

  config.vm.provision :shell, :inline => "sudo apt-get install -y build-essential --no-install-recommends"
  config.vm.provision :shell, :inline => "sudo apt-get install -y ruby1.9.1-dev --no-install-recommends"
  config.vm.provision :shell, :inline => "sudo apt-get install -y ruby1.9.3 --no-install-recommends"
  config.vm.provision :shell, :inline => "sudo gem install cf"
end
