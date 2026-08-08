# -*- mode: ruby -*-
# vi: set ft=ruby :

servers = [
  {
    ip: "192.168.56.11",
    name: "k3s-server-1",
    hostname: "k3s-server-1",
    main: true,
  },
  {
    ip: "192.168.56.12",
    name: "k3s-server-2",
    hostname: "k3s-server-2",
    main: false,
  },
  {
    ip: "192.168.56.13",
    name: "k3s-server-3",
    hostname: "k3s-server-3",
    main: false,
  }
]
servers_workers = [
  {
    ip: "192.168.56.21",
    name: "k3s-worker-1",
    hostname: "k3s-worker-1",
  },
  {
    ip: "192.168.56.22",
    name: "k3s-worker-2",
    hostname: "k3s-worker-2",
  },
  {
    ip: "192.168.56.23",
    name: "k3s-worker-3",
    hostname: "k3s-worker-3",
  }
]

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/jammy64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.

  # config.vm.network "private_network", ip: "192.168.56.9"
  # config.vm.network "forwarded_port", host: 8080, guest: 30007

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessible to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  # config.vm.synced_folder ".", "/vagrant", disabled: true

  servers.each do |server|

    config.vm.define server[:name] do |ser|

      ser.vm.hostname = server[:hostname]
      ser.vm.network "private_network", ip: server[:ip]

      ser.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
      end

      if server[:main]
        ser.vm.provision "shell", path: "./startup_main.sh"
      else
        ser.vm.provision "shell", path: "./startup_master.sh", args: [server[:ip], server[:name]]
      end

      ser.vm.provision "shell", inline: "cd /vagrant/ && sudo kubectl apply -f deployment-nginx.yaml && sudo kubectl apply -f service.yaml"

    end

  end

  servers_workers.each do |server|

    config.vm.define server[:name] do |ser|

      ser.vm.hostname = server[:hostname]
      ser.vm.network "private_network", ip: server[:ip]

      ser.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
      end

      ser.vm.provision "shell", path: "./startup_agent.sh", args: [server[:ip]]

    end

  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", path: "startup.sh"
end
