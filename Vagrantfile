# -*- mode: ruby -*-
# vim: set ft=ruby ts=2 sw=2 tw=0 et :

boxes = [
  {:name => "jenkins", :box => "opscode-ubuntu-14.04", :url => "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box", :ip => '10.0.142.2', :cpu_cap => "50", :cpus => 1, :ram => "512"},
]

Vagrant.configure("2") do |config|

  # add our vagrant private ssh key if it exists
  vagrant_key = File.expand_path('~') + '/.ssh/vagrant'
  vagrant_key_pub = File.expand_path('~') + '/.ssh/vagrant.pub'
  if FileTest.exists?(vagrant_key) and FileTest.exists?(vagrant_key_pub)
    config.ssh.private_key_path = [ vagrant_key, "~/.vagrant.d/insecure_private_key" ]
  end

  # auto-update virtualbox guest additions
  # avoids /vagrant mount failure
  # requires vagrant plugin vagrant-vbguest
  # config.vbguest.auto_update = true

  boxes.each do |box|
    config.vm.define box[:name] do |vms|
      vms.vm.box = box[:box]
      vms.vm.box_url = box[:url]
      vms.vm.hostname = "%s" % box[:name]

      vms.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--cpuexecutioncap", box[:cpu_cap]]
        v.customize ["modifyvm", :id, "--memory", box[:ram]]
        v.customize ["modifyvm", :id, "--cpus", box[:cpus]]
      end

      vms.vm.network :private_network, ip: box[:ip]

      # add our vagrant private key
      if config.ssh.private_key_path.kind_of?(Array) and config.ssh.private_key_path.include? vagrant_key
        vms.vm.provision :shell do |shell|
          vagrant_key_pub_content = File.read(vagrant_key_pub)
          shell.inline = "echo '#{vagrant_key_pub_content}' > /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"
        end
      end
      config.ssh.forward_agent = true

      vms.vm.provision :ansible do |ansible|
        ansible.playbook = "%s.yml" % box[:name]
        ansible.groups = {
          "backshop" => boxes.map {|b| b[:name]},
          box[:name] => box[:name]
        }
        ansible.verbose = "vvvv"
      end
    end
  end
end
