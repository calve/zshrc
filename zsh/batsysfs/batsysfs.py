#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import commands
import math
import subprocess
import sys
#from threading import Timer


#def battery_check():
rem = float(commands.getoutput("grep ^POWER_SUPPLY_CHARGE_NOW /sys/class/power_supply/BAT0/uevent | tr '=' ' ' | awk '{ print $2 }'"))
full = float(commands.getoutput("grep ^POWER_SUPPLY_CHARGE_FULL= /sys/class/power_supply/BAT0/uevent | tr '=' ' ' | awk '{ print $2 }'"))
state = commands.getoutput("cat /sys/class/power_supply/BAT0/status")

percentage = int((rem/full) * 10)

# Output

total_slots, slots = 10, []

#filled = int(math.ceil(percentage * (total_slots / 10.0))) * u'▸'
filled = int(math.ceil(percentage * (total_slots / 10.0))) * u'+'
#empty = (u'')+((total_slots - len(filled)-1) * u' ')
empty = "";
charge =  (u'↯').encode('utf-8')
charged =  (u'✓').encode('utf-8')
out = (filled + empty).encode('utf-8')

#color_green = '[32m'
color_green = '%{\033[32m%}%{\033[30m%}%{\033[42m%}'
color_yellow = '%{\033[33m%}%{\033[30m%}%{\033[43m%}'
color_red = '%{\033[31m%}%{\033[30m%}%{\033[41m%}'
color_reset = '%{\033[40m%}'
color_out = (
    color_green if len(filled) > 6
    else color_yellow if len(filled) > 4
    else color_red
)
inb = color_yellow + charge + " " + color_reset 
inb2 = color_green + charged + " " + color_reset
out = color_out + out + color_reset

if state == "Full":
    sys.stdout.write(inb2)
elif state == "Unknown":
    sys.stdout.write(inb2)
elif state == "Charging":
    sys.stdout.write(inb)
else:
    sys.stdout.write(out)

