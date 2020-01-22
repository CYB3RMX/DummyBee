#!/usr/bin/env python3

import os,sys,requests
from scapy.all import *

cyan='\u001b[96m'
red='\u001b[91m'
white='\u001b[0m'

intruder = str(sys.argv[1])
def GetInfo():
   try:
       packet = sr1(ARP(pdst=intruder), timeout=1, inter=0.1, verbose=0)
       intruderMAC = str(packet[0].hwsrc)
       vendor = requests.get("https://api.macvendors.com/{}".format(intruderMAC))
       print("\n-----Information about {}-----".format(intruder))
       print("{}[{}+{}]{} MAC Address: {}".format(cyan,red,cyan,white,intruderMAC))
       print("{}[{}+{}]{} Vendor: {}".format(cyan,red,cyan,white,vendor.text))
       print("-----------------------------------------\n")
   except:
       print("{}[{}!{}]{} An error occured.".format(cyan,red,cyan,white))
if __name__ == '__main__':
    perm = os.getuid()
    if perm != 0:
        print("{}[{}!{}]{} You must be a root.".format(cyan,red,cyan,white))
        sys.exit(1)
    else:
        GetInfo()
