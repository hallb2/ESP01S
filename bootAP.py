# This file is executed on every boot (including wake-boot from deep sleep)

import esp
import uos, machine
#import gc
import network
import webrepl
# import webrepl_setup

esp.osdebug(None)
# uos.dupterm(None, 1) # disable REPL on UART(0)
webrepl.start()
gc.collect()

ap_if = network.WLAN(network.AP_IF)
ap_if.config(essid="<AP_NAME>", authmode=network.AUTH_WPA_WPA2_PSK, password="<password>")
ap_if.active(True)
