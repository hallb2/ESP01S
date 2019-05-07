###########################################################################
# Setup code goes below, this is called once at the start of the program: #
###########################################################################
import webrepl
import webrepl_setup
import network

webrepl.start()
sta_if = network.WLAN(network.STA_IF); sta_if.active(True)
sta_if.connect("RackstarInks", "coolshirts") # Connect to an AP
sta_if.isconnected()  
