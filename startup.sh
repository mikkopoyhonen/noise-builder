#scripta 

#!/bin/bash

cd /etc

sudo yum install -y git

sudo yum install -y gcc-c++ make &
wait $!
echo Installed gcc-c++ and make
sleep 2
sudo yum install -y openssl-devel &
wait $!
echo Installed openssl-devel
sleep 3
sudo yum install -y ppp &
wait $!

wget http://poptop.sourceforge.net/yum/stable/rhel6/x86_64/pptpd-1.4.0-1.el6.x86_64.rpm &
wait $!

sudo yum -y localinstall pptpd-1.4.0-1.el6.x86_64.rpm &

wait $!

sudo git clone https://github.com/mikkopoyhonen/noisetester.git


sudo sed -i 's/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/g' /etc/sudoers

sudo git clone https://github.com/nodejs/node.git &
wait $!
echo Cloned node.git
sleep 2
echo entering nodejs workfolder

cd node
git checkout v0.12.2
sudo ./configure
make &
wait $!

sudo make install &
wait $!

sleep 3

sudo git clone https://github.com/isaacs/npm.git &
wait $!
echo cloned NPM

echo entering npm workfolder

cd npm
sudo make install &
wait $!

cd /etc

echo returned to /etc, now pulling Noise-tester


echo waiting for npm to finish installing
cd /etc/noisetester/server

 
sleep 20

npm install &
wait $!




read -p "Enter your IP address which you want to use for PPTP prefer elastic ip in amazon EC2 : " iplocal
echo "localip $iplocal" >> /etc/pptpd.conf

read -p "Enter ip address pool allocated to machines, for example 192.168.0.1-20 : " ipremote
echo "remoteip $ipremote" >> /etc/pptpd.conf

echo "Added $IPREMTOE as remote ip!"

read -p "Enter username for pptp : " uname
echo "Hi, $uname. Let us be friends!"


read -p "Enter your password for pptp : " pword
echo "$uname pptpd  $pword *" >> /etc/ppp/chap-secrets

sudo sed -i 's/#ms-dns 10.0.0.1/ms-dns  8.8.8.8/g' /etc/ppp/options.pptpd

sudo sed -i 's/#ms-dns 10.0.0.2/ms-dns  8.8.4.4/g' /etc/ppp/options.pptpd


sudo sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo service iptables save &
wait $!
sudo service iptables restart &
wait $!

sudo /sbin/sysctl -p

sudo service pptpd stop

sleep 1

sudo tc qdisc add dev eth0 root netem

sudo service pptpd start &
wait $!

sudo chkconfig pptpd on

cd /etc/noisetester/server/src

sudo node index.js




