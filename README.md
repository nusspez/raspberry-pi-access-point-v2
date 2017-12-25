# raspberry pi access point v2
access point from raspberry pi and raspbian stretch acccess point whit only install a shell script

## Getting Started
this raspberry pi accces point its works in raspbian stretch i test in raspberry pi zero y raspberry pi 3
in raspberry pi zero first i install the acccess point first in pi 3an then put the SD card in raspberry pi zero

- default settings

       ip:172.24.1.1
       ssid es:PI
       password raspberry

- notes

      change ssid in line 40 of code change ssid=NEWSSID
      change pasword in code line 48 change to wpa_passphrase=NEWPASWORD

## Prerequisites


- rapsberry pi 3

- ethernet cable

## Install

### Step 1


conect your raspberry pi to the current and the ethernet cable

### Step 2

download the repository

        git clone git://github.com/nusspez/raspberry-pi-access-point-v2

### Step 3

Give permissions

        cd raspberry-pi-access-point-v2
        chmod +x access.sh
        chmod 0755 access.sh

### Step 4

install the access point

       sudo ./access.sh


### Final step

- install the acccess point 1

- remove 2(dont work for the moment)

- info 3

- exit 4

## Test

conect the raspberry pi and then take your movil and in wifi setings search pi this is ypur access point

## Built With


- shell script

## Authors

- nusspez

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

give me a coffee https://www.paypal.me/PezNuss
