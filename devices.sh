#!/bin/bash

# Configurations
#devices=()
#declare -A devices
names=()
macs=()
protocols=()

# Declare template
#declare -A template
#template["name"]="value"
#template["mac_address"]="value"
#template["bms_protocol"]="value"

# Populate device list
#devices+=($template)
#devices+=($template)
#devices[0]=$template
#devices[0]["name"]="inverter/deye-01"
names[0]="inverter/deye-01"

#devices+=($template)
#devices[1]=$template
#devices[1]["name"]="inverter/deye-02"
names[1]="inverter/deye-02"

#devices+=($template)
#devices[2]=$template
#devices[2]["name"]="inverter/deye-03"
names[2]="inverter/deye-03"

macs=()
macs+=("C8:47:8C:EC:1E:60")
macs+=("C8:47:8C:E5:98:96")
macs+=("12:34:56:78:90:AB") # Dummy MAC Address

# Please "JK02" (hardware version >= 6.0 and < 11.0)
# Please use "JK02_32S" if you own a new JK-BMS >= hardware version 11.0 (f.e. JK-B2A8S20P hw 11.XW, sw 11.26)
# Please use "JK04" if you have some old JK-BMS <= hardware version 3.0 (f.e. JK-B2A16S hw 3.0, sw. 3.3.0)
protocols=()
protocols+=("JK02_32S") # HW v11.x for JK-BMS-BAT01
protocols+=("JK02_24S") # HW v10.x for JK-BMS-BAT02
protocols+=("JK02_DUMMY") # Dummy Protocol

num=${#devices[@]}
maxindex=$(($num - 1))
selected=$((-1))

# Enter hostname
#read -p "Enter hostname (only lowercase characters a-z, digits 0-9 and hypthens - are allowed): " name

# Select Configuration
#echo $selected
#echo $maxindex

while [[ $selected -gt $maxindex ]] || [[ $selected -lt 0 ]]
do
    for ((index=0;index<=$maxindex;index++))
    do
        arr="${devices[${index}]}"
        name=${arr["name"]}
        mac_address=${arr["mac_address"]}
        bms_protocol=${arr["bms_protocol"]}

        selection=$((index+1))
        echo -e "[${selection}]"
        echo -e "\t Hostname: ${name}"
        echo -e "\t MAC Address: ${mac_address}"
        echo -e "\t Protocol: ${bms_protocol}"
    done

    read -p "Enter desired configuration: " selection
    selected=$((selection-1))
    name=${names[$selected]}
    mac=${macs[$selected]}
    protocol=${protocols[$selected]}
done

echo "Hostname set to <$name>"
echo "MAC Addres set to <$mac>"
