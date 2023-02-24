#!/bin/bash
#Pratik Kumar (Modified@22ndFeb2022)
#To run this file sudo sh openlane_Setup.sh

Log_File=./installation.log

CommandLog () {
author='APR-Training'
startdate=$(date)
scriptName='installation.log'

echo "${author}"
echo "[$startdate]:[INSTALLATION]: This is ${scriptName}, which shows the loging of install_openLane.sh:"
set -ex
echo "=============================================="
echo "----Starting Basic Toolschain INSTALATTION----"
echo "=============================================="
echo

sudo apt -y update
sudo apt install -y build-essential -f
sudo apt-get install -y lsb-core
sudo apt install -y git-all
sudo apt install -y ufw
sudo apt-get install -y cmake
sudo apt-get update -y
sudo apt-get install -y device-tree-compiler
sudo apt-get install -y make
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
sudo apt install -y containerd
#sudo apt-get install python-pip
sudo apt-get install -y python3-pip
#sudo apt-get install -y python3-venv
sudo apt-get install -y python3.10-venv
sudo pip install --upgrade pip

echo "=================================="
echo "---KICK OFF DOCKER INSTALLATION---"
echo "=================================="

sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

sudo groupadd docker
sudo usermod -aG docker $USER
#If the docker installation fail restart and continue from this step
newgrp docker
docker run hello-world
docker --version


echo "=================================="
echo "----------DOCKER  ENABLED---------"
echo "=================================="


echo "=================================="
echo "-------KLAYOUT INSTALLATION-------"
echo "=================================="

sudo apt install -y klayout
# making tools folder
mkdir -p EDATool; cd EDATool

echo "=================================="
echo "--------MAGIC INSTALLATION--------"
echo "=================================="

# pre-req for magic
sudo apt-get install -y m4
sudo apt-get install -y csh
sudo apt-get install -y libx11-dev
sudo apt-get install -y libncurses-dev
sudo apt-get install -y tcl-dev tk-dev
sudo apt-get install -y blt-dev
sudo apt-get install -y freeglut3
sudo apt-get install -y libgl1-mesa-dev
sudo apt-get install -y libglu1-mesa-dev

git clone https://github.com/RTimothyEdwards/magic.git
cd magic
./configure
sudo make
sudo make install
magic --version
cd ../


echo "======================================"
echo "----KICK OFF OpenLane INSTALATTION----"
echo "======================================"
echo

git clone https://github.com/The-OpenROAD-Project/OpenLane.git
#Verify the path of OPenlane if this command fails
cd OpenLane/
#git checkout v0.23
make
make test # This is to test that the flow and the pdk were properly inst
} 


CommandLog | tee "${Log_File}"
#ErrorLog "Found error in logic to logging for investigation" | tee "${Log_File}"
