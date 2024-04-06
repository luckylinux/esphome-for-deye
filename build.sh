#!/bin/bash

# Define project
project="esphome-for-deye"

# Store current path
currentpath=$(pwd)

# Get Parent path
#parentpath=$(dirname $currentpath)

# Define board
board="esp32-s3-devkitc-1" # Works for Atom S3 Lite

# Define variant
variant="esp32s3" # Works for Atom S3 Lite

# Build folder
buildpath="$HOME/ESPHome"
mkdir -p $buildpath
cd $buildpath

# Create venv
sudo apt-get -y install python3.11-venv
python3 -m venv ./venv

# Active venv
source venv/bin/activate

# Install ESPHome
pip3 install esphome # Optionally specify the desired version

# Upgrade ESPHome
#pip install --upgrade esphome # Force upgrade to latest version

# Clone external component if needed
version=$(date +%Y%m%d)
###git clone https://github.com/syssi/esphome-jk-bms.git esphome-jk-bms-master
###cd esphome-jk-bms-master
###version="1.17.5"
###if [[ ! -f "esphome-jk-bms-can-$version.tar.gz" ]]
###then
###   wget https://github.com/Sleeper85/esphome-jk-bms-can/archive/refs/tags/V$version.tar.gz -O esphome-jk-bms-can-$version.tar.gz
###fi
###
###if [[ ! -d  "esphome-jk-bms-can-$version" ]]
###then
###   tar xvf esphome-jk-bms-can-$version.tar.gz
###fi
###cd $project-$version

mkdir -p $project
cd $project

# Configure Device based on Database
source $currentpath/devices.sh

# Set Secrets
source $currentpath/secrets.sh

# Define ESPHome configuration file
#esphomeconfig="esphome-config-$version-$type.yaml"
esphomeconfig="esphome-config-$type.yaml"

# Validate the configuration, create a binary, upload it, and start logs
# If you use a esp8266 run the esp8266-examle.yaml
cp $currentpath/$esphomeconfig ./$esphomeconfig
cp $currentpath/*.yaml ./

# Copy Required CSS/JS For WebServer into BuildFolder
cp -r $currentpath/web_server ./

# Copy Required Subpackages for Configuration
cp -r $currentpath/boards ./
cp -r $currentpath/config ./
cp -r $currentpath/modules ./

# Execute Text Replacement
source $currentpath/functions.sh
#replace_text "./$esphomeconfig" "board" "$board"
#replace_text "./$esphomeconfig" "variant" "$variant"

files=$(find ./ -iname "*.yaml")
for file in $files
do
   replace_text ./$file "board" "${board}"
   replace_text ./$file "variant" "${variant}"
   replace_text ./$file "mqtt_topic_prefix" "${topic_prefix}"
done

echo "Replaced Text"

# Clean Build Files to make sure all new/updated Entities Appear Correctly
esphome clean $esphomeconfig

# Build ESPHome
esphome run $esphomeconfig          # Normal Mode
#esphome --verbose run $esphomeconfig # Debug Mode

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
