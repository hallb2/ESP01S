# ESP-01S
This read-me file provides a detailed description of flashing and using the ESP-01S (ESP-8266) module as a stand-alone microcontroller.  

## Introduction
The ESP-01S is a WiFi serial transceiver module (contains an ESP-8266 microchip) with 1MB of flash memory (the dimensions and pinout can be found [here](https://github.com/hallb2/ESP01S/blob/master/Pictures/ESP-01S%20Pin%20Layout.jpeg). In particular, it is a lightweight and cheap method for home automation and DIY projects with its two GPIO pins. 

## Preface
This walkthrough assumes the user has a basic Linux distro such as Ubuntu. Walkthroughs for Windows and Mac operating systems are still being tested. 

## Materials Used 
- ESP-01S Module: [Pack of 5 on Amazon](https://www.amazon.com/DIYmall-ESP8266-ESP-01S-Serial-Transceiver/dp/B07LBD33NT/ref=sr_1_6?crid=1KOD0CXA9RMBZ&keywords=diymall+esp8266&qid=1556118754&s=electronics&sprefix=DIYmall+esp%2Cbeauty%2C132&sr=1-6)

- USB to ESP-01S Adapter: [Adapter with ESP-01S Module](https://www.amazon.com/ESP-01S-ESP8266-Wireless-Adapter-4-5-5-5V/dp/B07KF119YB/ref=pd_cp_147_1?pd_rd_w=WmEpL&pf_rd_p=ef4dc990-a9ca-4945-ae0b-f8d549198ed6&pf_rd_r=8EAED7B3EFC142PAMDQY&pd_rd_r=0d0aba62-66a3-11e9-bbed-57e65051719f&pd_rd_wg=fm7pu&pd_rd_i=B07KF119YB&psc=1&refRID=8EAED7B3EFC142PAMDQY)

## Flashing the ESP-01S Module With Micropython
- Begin by placing the ESP-01S module on the the adapter with the orientation of the ESP-01S facing inwards (<-- put link to picture. Make sure the switch on the adapter is set to PROG mode and not UART mode (the labels are on the bottom of the adapter). Plug the device into a USB port. The device has automatically been assigned a location, namely /dev/ttyUSB* (where * is some number). One way to determine this number is by opening up the terminal and typing 

> `dmesg | grep uart | sed '$!d'`

The USB/adapter device will henceforth be referred to as ttyUSB*, where * is the number that corresponds to your device. 
