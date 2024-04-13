#!/bin/bash

# Configurations
names=()
protocols=()
profiles=()
topic_prefixes=()

# Populate device list
# Inverter M01 (Master)
names[0]="deye-a"
profiles[0]="master"
topic_prefixes[0]="inverter/deye-a"

# Inverter S02 (Slave)
names[1]="deye-b"
profiles[1]="slave"
topic_prefixes[1]="inverter/deye-b"


# Inverter S03 (Slave)
names[2]="deye-c"
profiles[2]="slave"
topic_prefixes[2]="inverter/deye-c"


# Get nzumber of devices
num=${#names[@]}
maxindex=$(($num - 1))
selected=$((-1))

while [[ $selected -gt $maxindex ]] || [[ $selected -lt 0 ]]
do
    for ((index=0;index<=$maxindex;index++))
    do
        name=${names[$index]}
        profile=${profiles[$index]}

        selection=$((index+1))
        echo -e "[${selection}]"
        echo -e "\t Hostname: ${name}"
        echo -e "\t Profile: ${profile}"
    done

    read -p "Enter desired configuration: " selection
    selected=$((selection-1))
    name=${names[$selected]}
    profile=${profiles[$selected]}
    topic_prefix=${topic_prefixes[$selected]}
done

# Determine entities prefix for names
entities_name_prefix="${name}-sun12k"

# Determine entities prefix for ids (cannot contain dashes or spaces)
entities_id_prefix=${name//"-"/"_"}
entities_id_prefix="${entities_id_prefix}_sun12k"


# Echo
echo "Hostname set to <${name}>"
echo "Profile is <${profile}>"
echo "MQTT Topic: <${topic_prefix}>"
