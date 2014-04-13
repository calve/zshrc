import subprocess
import sys
import re


uevent_file = "/sys/class/power_supply/BAT0/uevent"
status_file = "/sys/class/power_supply/BAT0/status"
remaining_regex = "(?<=CHARGE_NOW=).*"
full_regex = "(?<=CHARGE_FULL=).*"
char_separator = ""
char_charging = "↯"
char_charged = "✓"
color_green1 = 22
color_green2 = 47
color_yellow1 = 226
color_yellow2 = 220
color_red1 = 160
color_red2 = 88


# System color name constants.
(
    BLACK,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    LIGHT_GRAY,
    DARK_GRAY,
    BRIGHT_RED,
    BRIGHT_GREEN,
    BRIGHT_YELLOW,
    BRIGHT_BLUE,
    BRIGHT_MAGENTA,
    BRIGHT_CYAN,
    WHITE,
) = range(16)
 
def rgb(red, green, blue):
    """
    Calculate the palette index of a color in the 6x6x6 color cube.
 
    The red, green and blue arguments may range from 0 to 5.
    """
    return 16 + (red * 36) + (green * 6) + blue
 
def gray(value):
    """
    Calculate the palette index of a color in the grayscale ramp.
 
    The value argument may range from 0 to 23.
    """
    return 232 + value
 
def set_color(fg=None, bg=None):
    """
    Print escape codes to set the terminal color.
 
    fg and bg are indices into the color palette for the foreground and
    background colors.
    """
    print(_set_color(fg, bg), end='')
 
def _set_color(fg=None, bg=None):
    result = ''
    if fg:
        result += '%%{\x1b[38;5;%dm%%}' % fg
    if bg:
        result += '%%{\x1b[48;5;%dm%%}' % bg
    return result
 
def reset_color():
    """
    Reset terminal color to default.
    """
    print(_reset_color(), end='')
 
def _reset_color():
    return '%{\x1b[0m%}'
 
def print_color(*args, **kwargs):
    """
    Print function, with extra arguments fg and bg to set colors.
    """
    fg = kwargs.pop('fg', None)
    bg = kwargs.pop('bg', None)
    set_color(fg, bg)
    print(*args, **kwargs)
    reset_color()
 
def format_color(string, fg=None, bg=None):
    return _set_color(fg, bg) + string + _reset_color()


def retreiveFile(filename):
    battery_file = open(filename,'r')
    tmp = battery_file.read()
    battery_file.close()
    return tmp

def getPercentage():
    battery_file = retreiveFile(uevent_file)
    full_re = re.search(full_regex,battery_file)
    remaining_re = re.search(remaining_regex,battery_file)
    full = float(full_re.group(0))
    remaining = float(remaining_re.group(0))
    return 100*remaining/full

def constructProgressBar():
    percentage = getPercentage()    
    length = int(percentage/10)
    tmp = ""
    for i in range(length):
        tmp = tmp + char_separator
    tmp = tmp + " "
    return tmp

def getPromptColor(prompt):
    """ Give a pair of color for a prompt, depending on length
    """
    slots=len(prompt)
    if slots > 6 :
        color1 = color_green1
        color2 = color_green2
    elif slots > 4:
        color1 = color_yellow1
        color2 = color_yellow2
    else:
        color1 = color_red1
        color2 = color_red2
    return (color1,color2)

def printProgressBar(prompt,color1=color_green1,color2=color_green2):
    """ Print the progress bar given two colors
    """
    for i in range(len(prompt)):

        # if i==len(prompt)-1 and prompt[i] != char_separator:
        #     if i%2 == 0 :
        #         print_color(prompt[i],fg=color2,bg=color1,end="")
        #     else :
        #         print_color(prompt[i],fg=color1,bg=color2,end="")
        # else:
        if i==0 :
            print_color(prompt[i],fg=color1,bg=None,end="")
        elif i%2 == 0 :
            print_color(prompt[i],fg=color1,bg=color2,end="")
        else:
            print_color(prompt[i],fg=color2,bg=color1,end="")


def prompt():
    """Actually print a prompt ready to insert in your shell"""
    state = retreiveFile(status_file)
    state = state[:-1] #Trim newline at the end of string
    if state == "Full":
        print_color(char_separator, fg=color_green1,bg=None,end="" )
        print_color(char_charged, bg=color_green1,end=" " )
    else:
        prompt=constructProgressBar()
        if state == "Charging":
            prompt = prompt + char_charging + " "
        color1,color2 = getPromptColor(prompt) 
        printProgressBar(prompt,color1,color2)

prompt()
