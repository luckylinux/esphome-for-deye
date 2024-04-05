#!/bin/bash

# Configurations
names=()
macs=()
protocols=()
types=()
topic_prefix=()

# Populate device list
# Inverter M01 (Master)
names[0]="deye-a"
types[0]="master"
#topic_prefix[0]="deye-a"
topic_prefix[0]="inverter/deye-a"

# Inverter S02 (Slave)
names[1]="deye-b"
types[1]="slave"
#topic_prefix[1]="deye-b"
topic_prefix[1]="inverter/deye-b"


# Inverter S03 (Slave)
names[2]="deye-c"
types[2]="slave"
#topic_prefix[2]="deye-c"
topic_prefix[2]="inverter/deye-c"


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

# Determine entities prefix
entities_prefix="${name}-sun12k"

# Echo
echo "Hostname set to <$name>"
echo "Type is <$type>"
echo "MQTT Topic Prefix: ${topic_prefix}"
echo "MQTT Topic: ${topic_prefix}/${entities_prefix}"
