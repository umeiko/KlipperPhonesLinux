## Removing Klipper

If you're not uesing klipper but want to use your phone as a normal Linux device, doing these to remove Klipper and related components.


    cd ~
    ./kiauh/kiauh.sh


Next, you will see an installation/uninstallation guide. Follow the guide to remove the installed Klipper components.
*During the uninstallation of some components, there may be errors and warnings, which can be ignored.*

After completing the uninstallation and exiting the management interface, further clean up the files.

    cd ~
    sudo rm -rf ./KlipperScreen
    sudo rm -rf ./.KlipperScreen-env
