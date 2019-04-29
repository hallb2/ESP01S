sudo -H pip install esptool

adapter_location="$(dmesg | grep uart | grep attached | tail -1 | awk 'NF{print $NF; exit}')"

echo $adapter_location

sudo esptool.py --port /dev/$adapter_location erase_flash

echo -e "Short the GND and RST pins on the adapter. Press enter to continue."
read enter

sudo esptool.py --port /dev/$adapter_location --baud 115200 write_flash --flash_size=detect 0 /home/$USER/Downloads/esp8266-20190125-v1.10.bin

echo "It worked"
