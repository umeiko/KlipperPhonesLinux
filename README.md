# KlipperPhonesLinux
[中文文档](./README_CN.md)

Turning your old phones into high-performance Klipper host machine running on Debian Linux!
![wt88047](pictures/1.jpg)
![wt88047](pictures/2.jpg)

## Features
- 💻 Native Linux `Ubuntu 20.04` distribution, with `CAN` compatibility
- 📱Equipped with a high-resolution capacitive touchscreen, providing an outstanding appearance
- 🚀 Low cost with exceptional CPU performance
- ⚡ DC supply, Power on simultaneously with your 3D printer
- 🌈 Pre-installed `Klipper` runtime environment, no need for secondary installation
- 🛠️ Integrated with various useful tools: `USB serial terminal`, `SSH service`, `WebSSH terminal`...
- 🌐 Community Support: Share experiences, solve problems, and collaborate with other enthusiasts to contribute to the development of this project.


## Supported Models
- Xiaomi Redmi 2 ([wt88047](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_Redmi2))
- Xiaomi Redmi 5 Plus ([xiaomi-vince](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Mi 5X ([xiaomi-tissot](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Mi A1 ([xiaomi-tissot](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Mi A2 Lite ([xiaomi-daisy](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi 6 Pro ([xiaomi-daisy](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi 4 Prime ([xiaomi-markw](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi Note 4 ([xiaomi-mido](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi S2 ([xiaomi-ysl](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi Y2 ([xiaomi-ysl](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones))
- Xiaomi Redmi 4x ([xiaomi-santoni](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_santoni))
- Xiaomi Note 2 ([xiaomi-scorpio](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/msm8996.md))
- Xiaomi 5 ([xiaomi-gemini](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini))
- Xiaomi 5s ([xiaomi-capricorn](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini))
- Xiaomi 5s plus ([xiaomi-natrium](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini))
- Huawei Maimang 5 ([huawei milan](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan))
- Huawei G9 (Plus) ([huawei milan](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan))
- Huawei Nova (Plus) ([huawei milan](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan))
- oneplus 3 ([oneplus3](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini))
- oneplus 3t ([oneplus3t](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini))
- No model for your device? No problem! [Porting Tutorial](https://github.com/umeiko/KlipperPhonesLinux/blob/main/LinuxKernels)
## Flashing Instructions:
- [Xiaomi Redmi 2](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_Redmi2)
- [Xiaomi Qualcomm 625 Models](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones)
- [Xiaomi Note 2](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/msm8996.md)
- [Xiaomi Redmi 4x](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_santoni)
- [Huawei Maimang 5 / G9 (Plus) / Nova (Plus)](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan)
- [Xiaomi 5 / 5s / 5s plus](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini)
- [oneplus 3 / 3t](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi-gemini)

## Quick Start After Flashing
- Connect to the terminal
  - Using the network (recommended)
    - Connect to your local network with KlipperScreen
    - Enter your phone's IP address in a web browser with port 8888, e.g., `192.168.31.124:8888`
    - Entering:
      - Host `0.0.0.0`
      - Port `22`
      - Username `umeko`
      - Password `1234`
    - Then you can connect into your phone's SSH console in the web page.
  - Using USB serial
    - Connect your phone to your computer with a USB cable; your computer will recognize it as a serial device.
    - Use `PuTTY` or other terminal software to access the terminal console.

- Connect to your 3D printer motherboard using an OTG adapter
  - In the command line, use the `lsusb` command to ensure the system recognizes your 3D printer motherboard.
    - Common motherboards will be displayed as `Qingheng`, `OpenMoko xxx`, etc.
    - If not recognized, check your cable connections.
  - Install Klipper firmware for your 3D printer motherboard.
    - Install cross-compiler

          sudo apt update
          sudo apt install avrdude gcc-avr binutils-avr avr-libc stm32flash libnewlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi pkg-config

    - Refer to [Klipper documentation](https://www.klipper3d.org/Installation.html) to compile and install Klipper firmware for your Printer's mainboard.

- Configure the 3D printer's configuration file
  - Obtain the configuration file from your printer motherboard supplier or find it in the [Klipper repository](https://github.com/Klipper3d/klipper/tree/master/config).

  - Open the `Fluidd` interface, accessible through a web browser at `your phone's IP address`, e.g., `192.168.31.124`

  - In the `Config` tab on the left, rename your motherboard configuration file to `printer.cfg` and overwrite the original file.
  - At the end of `printer.cfg`, add `[include fluidd.cfg]`.
  - ⚠️ Please **do not** overwrite or delete the `moonraker.conf` file on the phone, as this can cause serious errors.

- Now you have completed the basic configuration. Enjoy!

## Convert Your Phone to DC Power Supply ( PCB )

- [Xiaomi Redmi 2 (wt88047)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi2)
- [Xiaomi Redmi Note 4x (xiaomi-mido)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi_Note4x)
- [Xiaomi Redmi 4 Prime(xiaomi-markw)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi4_Prime)
- [Xiaomi Note 2](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi4_Prime)


## Common Issues and Solutions:
- [Enabling and configuring CAN](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/CAN_BUS.md)
- [Connecting console with usb cable](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/USB_CONSOLE.md)
- Error during homing, 'timer too close'
  - If you have a Qualcomm Snapdragon 625 model, disable CPU temperature monitoring in Klipper settings.
    - Found if `sensor_type: temperature_mcu` or `sensor_type: temperature_host` in your configuration files, then removes them.
- [`lsusb` shows no reaction](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB)
- [Rotate the screen](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/ROTATE_THE_SCREEN.md)
- [Compile your own Linux kernel](https://github.com/umeiko/KlipperPhonesLinux/tree/main/LinuxKernels)
- [Uninstall the Klipper related components.](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/REMOVE_KLIPPER.md)
- [Setup multiple printers on KlipperScreen](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/MULTIPLE_PRINTERS_ONSCREEN.md)

## Acknowledgements
- [PostmarketOS](https://postmarketos.org/)
  - Real Linux distribution for phones and other mobile devices
- [Klipper](https://github.com/Klipper3d/)
  - Klipper 3d-Printer firmware. It combines the power of a general purpose computer with one or more micro-controllers.
- [moonraker](https://github.com/Arksine/moonraker)
  - API Web Server for Klipper
- [KlipperScreen](https://github.com/KlipperScreen/KlipperScreen)
  - Touchscreen GUI that interfaces with Klipper via Moonraker.
- [fluidd](https://github.com/fluidd-core/fluidd)
  - Free and open-source Klipper web interface for managing your 3d printer.

