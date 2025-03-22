# Important Notice:
DO NOT USE RS485 ON THE BMS - PORT! This port only has a baudrate of 9600, which is too slow for regular updates.
Use the Modbus port.
Configure it to a baudrate (in the Advanced Menu) of 115200. This allows for updates every second.

# ESPhome for deye
ESPhome configuration for monitoring and control of Deye inverters in Home Assistant.
This include all addresses i could see relevant from the inverter.
![image](https://user-images.githubusercontent.com/22115157/211201343-1d54cada-4b2c-40b0-88c4-faf31e17fead.png)

## Supported devices
Made specially for Deye 3phase low voltage inverters
* SUN-12K-SG04LP3(confirmed)
* SUN-8K-SG04LP3
* SUN-6K-SG04LP3
* SUN-5K-SG04LP3

## Unsupported devices
Sunsync & other 1phase inverters as they use different addresses and have different modbus port. Those inverters are not allowed in Denmark where i live because of a rule of maximum 16A for 1phase equitment.
I can only refer to this powerforum thread. https://powerforum.co.za/topic/8646-my-sunsynk-8kw-data-collection-setup/

## Requirements
* ESP32 / ESP32S3
* TTL To RS485 Module with automatic flow control

## Installation process
1. Create your esp32 in esphome in home assistant
2. Upload the your basis config via. usb from pc.
3. Test wireless upload
4. Copy all content (make sure you have your wifi ssid&password in the secrets)
5. Edit the sensors in the config if you like
6. Upload wireless

## Set Device List
Set your Device List in `devices.sh`.

## Set Secrets
Copy `secrets.sh.example` to `secrets.sh`:

```
cp secrets.sh.example secrets.sh
```

Set your Secrets for WiFi, MQTT, OTA, Web_Server, etc.

## Set up Build Environment and Build & Run ESPHome
The whole process is automated.

This has been tested on Ubuntu GNU/Linux but it should also work on Debian GNU/Linux and similar Distributions.

Otherwise you'll need to adapt the `apt` command and the package to install `python3.11-venv` to provide the `venv` python module.

It might already be installed in your system "by default" with the "standard" Python Distribution.

Run:

```
./build.sh
```

## Upgrading ESPHome Installation
The `build.sh` script takes care of the original installation of ESPHome within a Python venv.

The instructions for upgrading ESPHome are also outlined in `build.sh`, but the command is DISABLED by default, in order to prevent automatic Upgrades in case of e.g. Bugs / Incompatibilities / Regressions / etc. 

Either uncomment the line in `build.sh` to force an upgrade (and re-comment it afterwards to prevent further automatic upgrades), or run (in the case of BASH shell):

```
# Active Python venv
source ~/ESPHome/venv/bin/activate

# Upgrade ESPHome
# Force upgrade to latest version
pip install --upgrade esphome
```

## Hardware diagram

RX / TX between esp and ttl converter way have to be swapped. This seems to be a little different from espboard to espboard.
Check Termination: check that 120 Ohm are between B+ and B- (short wire); for long wire use 120 Ohms on both sides.
If it dosent communicate(RX/TX led both blinking) Try swap rx/tx on the esp.

I powered the esp32 from CN2 pin 7&8 with 12V into a USB converter.
(BE AWARE THAT IF YOU POWER OFF THE INVERTER REMOTELY, YOU CANT POWER IT UP AGAIN REMOTELY AS THE POWER TO THE ESP IS GONE)

![esp32 rs485_bb](https://user-images.githubusercontent.com/22115157/211201233-f5fe9189-e6b3-4ee1-9baa-48068f078127.jpg)

![image](https://github.com/luckylinux/esphome-for-deye/assets/7126291/615df540-39a8-4c8b-96da-6476480698f5)

## Home assistant user interface
For the card i use for the time of use settings like the inverters interface. Use the add-on "multiple entity row" from HACS and inspiration from my configuration of it below.
* https://github.com/klatremis/esphome-for-deye/blob/main/time%20of%20use%20card


