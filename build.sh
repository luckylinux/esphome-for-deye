#!/bin/bash

# Define project
project="esphome-for-deye"

# Store current path
currentpath=$(pwd)

# Get Parent path
parentpath=$(dirname $currentpath)

# Define board
board="esp32-s3-devkitc-1" # Works for Atom S3 Lite

# Define variant
variant="esp32s3" # Works for Atom S3 Lite

# Build folder
buildpath="$HOME/ESPHome"
mkdir -p $buildpath
cd $buildpath

# Create venv
apt-get -y install python3.11-venv
python3 -m venv ./venv

# Active venv
source venv/bin/activate

# Install esphome
pip3 install esphome

# Clone external component if needed
#git clone https://github.com/syssi/esphome-jk-bms.git esphome-jk-bms-master
#cd esphome-jk-bms-master
#version="1.17.5"
#if [[ ! -f "esphome-jk-bms-can-$version.tar.gz" ]]
#then
#   wget https://github.com/Sleeper85/esphome-jk-bms-can/archive/refs/tags/V$version.tar.gz -O esphome-jk-bms-can-$version.tar.gz
#fi
#
#if [[ ! -d  "esphome-jk-bms-can-$version" ]]
#then
#   tar xvf esphome-jk-bms-can-$version.tar.gz
#fi
#cd $project-$version

mkdir -p $project
cd $project

# Define ESPHome configuration file
#esphomeconfig="esp32-ble-$version.yaml"
esphomeconfig="esphome_config_2023-08-10.yaml"

# Configure Device based on Database
source $parentpath/devices.sh

# Set Secrets
source $parentpath/secrets.sh

# Validate the configuration, create a binary, upload it, and start logs
# If you use a esp8266 run the esp8266-examle.yaml
cp $currentpath/$esphomeconfig ./$esphomeconfig

# Copy Required CSS/JS For WebServer into BuildFolder
cp -r $currentpath/web_server ./

# Execute Text Replacement
source $parentpath/functions.sh
replace_text "./$esphomeconfig" "board" "$board"
replace_text "./$esphomeconfig" "variant" "$variant"

# Build ESPHome
esphome run $esphomeconfig

# Manage errors & try again
echo -e "In case of errors, it is suggested to run: esphome clean.\n"
read -p "Do you want to clean the build files & try build again: [Y/N] " tryagain
echo -e "\n"

# Clean build files and try again ?
if [ "$tryagain" == "Y" ] || [ "$tryagain" == "y" ]
then
   # Run clean & try again"
   esphome clean $esphomeconfig
   esphome run $esphomeconfig
fi

# Change back to currentpath
cd $currentpath
