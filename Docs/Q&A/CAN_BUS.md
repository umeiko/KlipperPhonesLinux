# What is a CAN Board?
[中文文档](./CAN_BUS_CN.md)
- A CAN board can be understood as another sub-board of the printer, which is at the same level as your mainboard. The difference from the mainboard is that the CAN board communicates with the upper computer using the CAN protocol, while the regular mainboard uses the UART protocol to communicate with the upper computer.
```
LINUX Host
  ├── USB 1
  │   └── U2C (usb-to-can)
  │       └── CAN Toolhead
  ├── USB 2
  │   └── USB to Serial Module
  │       └── Printer Mainboard
  ├── USB 3
  │   └── WEB Camera
  └──  ...
```



# How Does CAN Work?
- In STM32 and Raspberry Pi rp2040, CAN communication is implemented by programming to drive two GPIOs. Therefore, without pre-burning the corresponding program, the CAN port of the CAN board does not have any functionality.

# Steps to Use CAN
1. Burn the CANBOOT firmware: This step involves writing the program to the CAN board via USB or a downloader, enabling the CAN board to communicate through the CAN interface.
2. Use CAN to burn the Klipper firmware: In this step, the Klipper firmware is burned to the CAN board via the CAN bus.
   Note: The communication bit rate is not the higher, the better; on the contrary, lower bit rates have stronger anti-interference. It is generally recommended between 500K and 100K.

# Different Methods for Burning CAN Master Control
- For rp2040, burning CANBOOT generally uses a Windows computer to drag the firmware into the virtual U disk.
- For STM32, there are many methods for burning. After generating the firmware, it can be downloaded using DFU, USB, CDC, STlink downloader, etc. It is not much different from regular STM32 development boards.

## Possible Issues When Burning STM32 in DFU Mode Using a Linux System:
- `No DFU capable USB device available.` You can try copying the firmware to a Windows computer and using DFU to download the program.
  Download DFU driver for Windows: https://zadig.akeo.ie/

# Configuring CAN in Klipper-Phone-Linux
The firmware package supports the use of CAN!
The upper computer system has enabled the CAN module and configured the "Automatically Start CAN" and "Plug and Play Automatically Start CAN." Please do not configure related settings again.
- Modify the appropriate CAN parameters (after modification, please "power off" and restart the printer):

        sudo nano /home/auto_can_up.sh

Find the corresponding command line and change the CAN configuration you want, such as `bitrate` and `quelen`.

- Use the following command to view the CAN device ID:

        ~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0

For example:
If "Found canbus_uuid=11aa22bb33cc" appears, the device ID is found.
The "11aa22bb33cc" is the device UUID, which can be directly filled into the Klipper configuration file.
If no ID appears or an error occurs, please read the documentation carefully and check the wiring.
