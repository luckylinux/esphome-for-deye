#!/bin/bash

# Configurations
names=()
macs=()
protocols=()
types=()

# Populate device list
# Inverter M01 (Master)
names[0]="inverter/deye-01"
types[0]="master"

# Inverter S02 (Slave)
names[1]="inverter/deye-02"
types[1]="slave"

# Inverter S03 (Slave)
names[2]="inverter/deye-03"
types[2]="slave"

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
done

echo "Hostname set to <$name>"
echo "Type is <$type>"
