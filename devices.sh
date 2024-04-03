#!/bin/bash

# Configurations
names=()
macs=()
protocols=()
types=()
topic_prefix=()

# Populate device list
# Inverter M01 (Master)
names[0]="deye-01"
types[0]="master"
topic_prefix[0]="inverter"

# Inverter S02 (Slave)
names[1]="deye-02"
types[1]="slave"
topic_prefix[1]="inverter"

# Inverter S03 (Slave)
names[2]="deye-03"
types[2]="slave"
topic_prefix[2]="inverter"

# Get nzumber of devices
num=${#names[@]}
maxindex=$(($num - 1))
selected=$((-1))

while [[ $selected -gt $maxindex ]] || [[ $selected -lt 0 ]]
do
    for ((index=0;index<=$maxindex;index++))
    do
        name=${names[$index]}
        type=${types[$index]}

        selection=$((index+1))
        echo -e "[${selection}]"
        echo -e "\t Hostname: ${name}"
        echo -e "\t Type: ${type}"
    done

    read -p "Enter desired configuration: " selection
    selected=$((selection-1))
    name=${names[$selected]}
    type=${types[$selected]}
    topic_prefix=${topic_prefix[$selected]}
done

echo "Hostname set to <$name>"
echo "Type is <$type>"
echo "MQTT Topic Prefix: ${topic_prefix}"
echo "MQTT Topic: ${topic_prefix}/${name}"
