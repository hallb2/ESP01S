# ESP-01S
This read-me file provides a detailed description of flashing and using the ESP-01S (ESP-8266) module as a stand-alone microcontroller.  

## Introduction
The ESP-01S is a WiFi serial transceiver module (contains an ESP-8266 microchip) with 1MB of flash memory (the dimensions and pinout can be found [here](https://github.com/hallb2/ESP01S/blob/master/Pictures/ESP-01S%20Pin%20Layout.jpeg)). In particular, it is a lightweight and cheap method for home automation and DIY projects with its two GPIO pins. 

## Preface
This walkthrough assumes the user has a basic Linux distro such as Ubuntu, as well as Python 3.4 or higher with pip3 installer. Walkthroughs for Windows and Mac operating systems are still being tested. 

## Materials Used 
- ESP-01S Module: [Pack of 5 on Amazon](https://www.amazon.com/DIYmall-ESP8266-ESP-01S-Serial-Transceiver/dp/B07LBD33NT/ref=sr_1_6?crid=1KOD0CXA9RMBZ&keywords=diymall+esp8266&qid=1556118754&s=electronics&sprefix=DIYmall+esp%2Cbeauty%2C132&sr=1-6)

- USB to ESP-01S Adapter: [Adapter with ESP-01S Module](https://www.amazon.com/ESP-01S-ESP8266-Wireless-Adapter-4-5-5-5V/dp/B07KF119YB/ref=pd_cp_147_1?pd_rd_w=WmEpL&pf_rd_p=ef4dc990-a9ca-4945-ae0b-f8d549198ed6&pf_rd_r=8EAED7B3EFC142PAMDQY&pd_rd_r=0d0aba62-66a3-11e9-bbed-57e65051719f&pd_rd_wg=fm7pu&pd_rd_i=B07KF119YB&psc=1&refRID=8EAED7B3EFC142PAMDQY)

## Flashing the ESP-01S Module With Micropython
Begin by placing the ESP-01S module on the the adapter with the orientation of the ESP-01S facing inwards (see [here](https://github.com/hallb2/ESP01S/blob/master/Pictures/ESP-01S%20Orientation%20with%20Adapter.jpg)). Make sure the switch on the adapter is set to PROG mode and not UART mode (the labels are on the bottom of the adapter). Plug the device into a USB port. The device has automatically been assigned a location, namely /dev/ttyUSB* (where * is some number). One way to determine this number is by opening up the terminal and typing 

> `dmesg | grep uart | sed '$!d'`

The USB/adapter device will henceforth be referred to as ttyUSB0, so make the appropriate substitution when entering terminal commands. 

We first begin by erasing the flash memory of the module using the Python package esptool. This requires Python 2.7 or Python 3.4 (or higher) to compile, and can be downloaded through pip using the terminal command

> `sudo -H pip3 install esptool`

Now we can erase the flash memory of the module via the terminal command

> `sudo esptool.py --port /dev/ttyUSB0 erase_flash`

One issue I had on several machines was "A fatal error occurred.. Timed out waiting for packet header". If you receive this error, simply unplug and plug the device back into the usb port. This sometimes changes the ttyUSB number, so check and run again. You should see "Detecting chip type... Hard resetting..." 

Now we need to download the <a href="https://micropython.org/download#esp8266">Micropython firmware</a>. In my case, I will use the most recent stable build, namely esp8266-20190125-v1.10.bin. Change directory to where you downloaded the .bin file to, and run the terminal command

> `sudo esptool.py --port /dev/ttyUSB0 --baud 115200 write_flash --flash_size=detect 0 esp8266-20190125-v1.10.bin`

If you receive "A fatal error occurred.. Timed out" message again, once again unplug and plug the device back in and run the above line again. You should see "Detecting chip type.. Hard resetting.." Finally, remove the usb adapter from the port, toggle the switch from PROG to UART, and plug the adapter back in.

## Accessing Micropython Through Ampy and Picocom

[Ampy (Adafruit Micropython Tool)](https://github.com/pycampers/ampy) is a utility we will use to interact with Micropython over the serial connection. We can download Ampy through the commmand line, namely

> 'sudo -H pip3 install --user adafruit-ampy'

Picocom is a minimal dumb-terminal emulation program that will be used to 
