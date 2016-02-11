#!/bin/bash


1sudo yum install -y gcc-c++ make &
wait $!
echo Installed gcc-c++ and make
sleep 2
sudo yum install -y openssl-devel &
wait $!
echo Installed openssl-devel
sleep 3
sudo yum install -y git &
wait $!
echo Installed GIT!
sleep 2
sudo yum install -y ppp &
wa $!
sudo wget http://poptop.sourceforge.net/yum/stable/packages/pptpd-1.3.4-2.el6.x86_64.rpm &
wait $!

sudo rpm -Uhv pptpd-1.3.4-2.el6.x86_64.rpm &
wait $!



sudo git clone https://github.com/nodejs/node.git &
wait $!
echo Cloned node.git
sleep 2
echo entering nodejs workfolder

cd node
git checkout v0.12.2
sudo ./configure
make
sudo make install
sudo git clone https://github.com/isaacs/npm.git &
wait $!
echo cloned NPM

echo entering npm workfolder

cd npm
sudo make install

cd /etc 

echo returned to /etc, now pulling Noise-tester

sudo git clone https://github.com/mikkopoyhonen/noisetester.git &
wait &!

echo now entering noise-tester workfolder
cd noisetester/server

sudo make install &
wait &!
echo installing noice-tester and enabling services

cd src

sudo node index.js

echo 


sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sudo service iptables save

sudo service iptables restart

sudo chkconfig pptpd on
sleep 5
sudo init6