# Edit the KlipperScreen config file.
`sudo nano /root/KlipperScreen.conf`

    [main]
    default_printer: Local
    
    [printer Local]
    # Define the moonraker host/port if different from 127.0.0.1 and 7125
    moonraker_host: 127.0.0.1
    # ports 443 and 7130 will use https/wss
    moonraker_port: 7125
    
    [printer Ender3]
    # Define the moonraker host/port if different
    moonraker_host: 192.168.1.123
    # ports 443 and 7130 will use https/wss
    moonraker_port: 7125
    
    
    #~# --- Do not edit below this line. This section is auto generated --- #~#
    #~#
    #~# [main]
    #~# screen_blanking = 60
    #~#

`ctrl + O` to save and  `ctrl + X` to exit.

Then reboot your machine.

