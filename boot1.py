# This file is executed on every boot (including wake-boot from deepsleep)
#import esp
#esp.osdebug(None)
import uos, machine
#uos.dupterm(None, 1) # disable REPL on UART(0)
import gc
import webrepl
import network
#import webrepl_setup
webrepl.start()
gc.collect()

ap_if = network.WLAN(network.AP_IF); ap_if.active(True)
