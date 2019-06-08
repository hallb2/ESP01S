installation()
{
    sudo -H pip install esptool
    sudo -H pip install --upgrade git+https://github.com/adafruit/ampy
}

device_finder()
{
    adapter_location="$(dmesg | grep uart | grep attached | tail -1 | awk 'NF{print $NF; exit}')"
}

upload_micropython()
{
    # Erase flash
    sudo esptool.py --port /dev/$adapter_location erase_flash

    # Reset adapter
    echo -e "\nUnplug and plug the adapter back in. Press enter to continue."
    read enter

    # Upload Micropython firmware
    sudo esptool.py --port /dev/$adapter_location --baud 115200 write_flash --flash_size=detect 0 esp8266-20190125-v1.10.bin

    # Reset adapter
    echo -e "\nUnplug the adapter and toggle the switch from PROG to UART. Plug adapter back in. Press enter to continue."
    read enter

    # sudo ampy -b 115200 --port /dev/$adapter_location put boot.py
}

connect()
{
    echo -e "\nType (AP) to setup the ESP module as an access point, or type (ST) to connect the ESP to a wireless network."
    read access

    if [ "$access" == "AP" ]
    then
        echo -e "\nChoose access point name:"
        read name

        echo -e "\nCreate password for access point:"
        read -s password

        sed -e 's/<AP_NAME>/'$name'/g' -e 's/<password>/'$password'/g' bootAP.py > boot.py
        
        sudo ampy -b 115200 --port /dev/$adapter_location put boot.py 
	
	rm boot.py

	sudo picocom -b 115200 /dev/$adapter_location

    elif [ "$access" == "ST" ]
    then
        echo -e "\nType wifi name:"
        read name

        echo -e "\nType password:"
        read -s password

        sed -i 's/<AP_name>/'$name'/g' bootST.py
        sed -i 's/<password>/'$password'/g' bootST.py

        sudo ampy -b 115200 --port /dev/$adapter_location put bootST.py boot.py
    
    else
        connect
    fi

    # sudo ampy -b 115200 --port /dev/$adapter_location reset

}

if [ "$1" == "installation" ] 
then
    installation
fi

if [ "$1" == "upload_micropython" ]
then
    device_finder
    upload_micropython
fi

if [ "$1" == "connect" ]
then
    device_finder
    connect
fi

if [ -z "$1" ]
then
    installation
    device_finder
    upload_micropython
    connect
fi



