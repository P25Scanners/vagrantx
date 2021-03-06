#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y git gdb


###################
# Alt approach not involving pybombs
# Options include
#   just using cmake
#   using backportpackage to get a version of gnuradio (3.7.3) into a PPA which can simply be fetched using apt-get
###################
#apt-get install -y g++ git gdb swig
#
#sudo apt-get install -y libsndfile1-dev libcppunit-dev libitpp-dev cmake libboost-all-dev libncurses5-dev 
#
#
##sudo apt-get install -y gnuradio-dev
#
#sudo apt-get install -y libpcap-dev
#
#cd /home/vagrant/
#git clone --recursive https://github.com/gnuradio/gnuradio
#cd gnuradio
#mkdir build && cd build
#cmake ..
#make
#sudo make install
#sudo ldconfig
#
#cd /home/vagrant/
#git clone https://github.com/robotastic/gr-dsd.git
#cd gr-dsd
#mkdir build && cd build
#cmake ..
#make
#sudo make install
#sudo ldconfig
#
#git clone git://op25.osmocom.org/op25.git
#cd op25
#mkdir build && cd build
#cmake ..
#make
#sudo make install
#sudo ldconfig
#
## this didn't work, and the 0.0.0 thing makes me think noone expected it to work
## sudo apt-get install libgnuradio-osmosdr0.0.0
## more recent versions require gnuradio 3.7.3, but the packaged version was only 3.7.2
#git clone --branch v0.1.1 git://git.osmocom.org/gr-osmosdr
#cd gr-osmosdr
#mkdir build && cd build
#cmake ..
#make
#sudo make install
#sudo ldconfig
#
#git clone https://github.com/robotastic/trunk-recorder.git
#cd trunk-recorder
#mkdir build && cd build
#cmake ..
#make
#sudo make install
#sudo ldconfig
#
###################


git clone https://github.com/gnuradio/pybombs.git

sudo chown -R vagrant:vagrant pybombs

cd pybombs
# git checkout 351cff306adc1ade7ae1c7af1bca19ae8076437a
# checkout slightly older version because they may have pulled in a bug

sudo chown -R vagrant:vagrant src 

git config --global --unset http.proxy

dd if=/dev/zero of=/swapfile1.swap bs=1024 count=524288
chown root:root /swapfile1.swap
chmod 0600 /swapfile1.swap
mkswap /swapfile1.swap
swapon /swapfile1.swap
echo '/swapfile1.swap none swap sw 0 0' >> /etc/fstab

#cd pybombs
cp config.defaults config.dat
sed -i 's/\[defaults\]/\[config\]/g' config.dat
sed -i 's/makewidth\=4/makewidth\=1/g' config.dat
./pybombs -vf install uhd

./pybombs -vf install gnuradio




#pwd
#ls -a
./pybombs env
source /usr/local/setup_env.sh
cd ../

#git clone https://github.com/gnuradio/gnuradio.git
#cmake 
#make test
#make install

#GR-DSD
sudo apt-get install -y libsndfile1-dev libcppunit-dev libitpp-dev cmake libboost-all-dev libncurses5-dev

git clone https://github.com/robotastic/gr-dsd.git
cd gr-dsd

cmake -DCMAKE_PREFIX_PATH=/home/vagrant/pybombs/gnuradio  .
# -DCMAKE_MODULE_PATH=/home/vagrant/gnuradio/cmake/Modules   
make
sudo make install
sudo ldconfig

cd ../

#OP25 INSTALL
cd pybombs
./pybombs install -vf gr-op25
cd ../



#TRUNK RECORDER INSTALL
git clone https://github.com/robotastic/trunk-recorder.git
cd trunk-recorder
cmake -DCMAKE_PREFIX_PATH=/home/vagrant/pybombs/gnuradio  .
#-DCMAKE_MODULE_PATH=/home/vagrant/gnuradio/cmake/Modules   
make

sudo chown -R vagrant /home/vagrant/trunk-recorder
sudo chmod -R u+rwx /home/vagrant/trunk-recorder
