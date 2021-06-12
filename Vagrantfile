# -*- mode: ruby -*-
# vi: set ft=ruby :
$hostsfile_update = <<-'SCRIPT'
echo "
192.168.56.110 control.example.com control co
192.168.56.111 node1.example.com node1 no1 n1
192.168.56.112 node2.example.com node2 no2 n2
" >> /etc/hosts
id ansible || useradd -m -g vagrant ansible

mkdir -p ~ansible/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOFHVM52dLxvLsL0hQOXRNcRUpwszVvsaAihokSciEd john@mcgru-ant" >> ~ansible/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8cDx29OkWUCBpG6dhhw/1rfsc1n5Etk7Ljo9/IiTRT john@mcgru-ant" >> ~ansible/.ssh/authorized_keys

mkdir -p  ~root/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINOFHVM52dLxvLsL0hQOXRNcRUpwszVvsaAihokSciEd john@mcgru-ant" >> ~root/.ssh/authorized_keys

sed -ri 's/^\s*PasswordAuthentication\s+no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && systemctl restart sshd
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define "control", primary: true do |control|
    control.vm.box = "centos/8"
###    control.vm.hostname = "control.example.com"
    control.vm.network "forwarded_port", guest: 80, host: 8080
    control.vm.network "private_network", ip: "192.168.56.110"
    control.vm.provision "shell", inline: $hostsfile_update
    control.vm.provision "shell", inline: <<-RUN
      echo "control.example.com" > /etc/hostname
      hostname control.example.com
echo "-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBPHA8dvTpFlAgaRunYYcP9a37HNZ+RLZOy46PfyIk0UwAAAJihVYEfoVWB
HwAAAAtzc2gtZWQyNTUxOQAAACBPHA8dvTpFlAgaRunYYcP9a37HNZ+RLZOy46PfyIk0Uw
AAAEAqXQeWigoskoCrEtXYHJb58/vxiH55zoj9pXkrFBY5SU8cDx29OkWUCBpG6dhhw/1r
fsc1n5Etk7Ljo9/IiTRTAAAADmpvaG5AbWNncnUtYW50AQIDBAUGBw==
-----END OPENSSH PRIVATE KEY-----" > ~vagrant/.ssh/id_ed25519
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8cDx29OkWUCBpG6dhhw/1rfsc1n5Etk7Ljo9/IiTRT john@mcgru-ant" > ~vagrant/.ssh/id_ed25519.pub
chmod 600 ~vagrant/.ssh/id_ed25519
chown vagrant: ~vagrant/.ssh/id_ed25519*
    RUN
    config.vm.provider "virtualbox" do |v|
     v.memory = 4096
     v.cpus = 2
     v.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

  config.vm.define "node1" do |node1|
    node1.vm.box = "centos/8"
###    node1.vm.hostname = "node1.example.com"
    node1.vm.network "private_network", ip: "192.168.56.111"
    node1.vm.provision "shell", inline: $hostsfile_update
    config.vm.provision "shell", inline: <<-RUN
      echo "node1.example.com" > /etc/hostname
      hostname node1.example.com
    RUN
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

  config.vm.define "node2" do |node2|
    node2.vm.box = "centos/8"
###    node2.vm.hostname = "node2.example.com"
    node2.vm.network "private_network", ip: "192.168.56.112"
    node2.vm.provision "shell", inline: $hostsfile_update
    config.vm.provision "shell", inline: <<-RUN
      echo "node2.example.com" > /etc/hostname
      hostname node2.example.com
    RUN
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

end
