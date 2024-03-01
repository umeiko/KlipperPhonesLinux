# KlipperPhonesLinux
Building an Klipper Machine Host for a 3D Printer Based on Native Linux System Adapted for Mobile Phones

让你的旧手机变为高性能Linux系统的Klipper上位机
![wt88047](pictures/1.jpg)
![wt88047](pictures/2.jpg)

## KlipperPhones上位机的特点
- 原生Linux系统: `Ubuntu-20.04`发行版，兼容性极佳
- 高分辨率电容触摸屏, 非常良好的外观
- 极低的成本, 超高的cpu性能
- 集成`Klipper`运行环境，无需二次安装
- 集成各种实用工具: USB串口终端, SSH服务, WebSHH终端...
- 社区支持：在 GitHub 的社区中，你可以与其他改装爱好者交流心得，解决问题，共同推动这个项目的发展。

## 支持的机型
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
- Xiaomi Redmi 4x (xiaomi-santoni)
- Xiaomi Note 2 ([xiaomi-scorpio](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/msm8996.md))
- Huawei Maimang 5 ([huawei milan](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan))
- 没有你的机型？没关系！[移植教程](https://github.com/umeiko/KlipperPhonesLinux/blob/main/LinuxKernels)

## 刷机方法：
- [Xiaomi Redmi 2](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_Redmi2)
- [小米高通625机型](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Xiaomi_msm8953_Phones)
- [Xiaomi Note2](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/msm8996.md)
- [Xiaomi Redmi 4x]()
- [Huawei Maimang 5](https://github.com/umeiko/KlipperPhonesLinux/releases/tag/Huawei_milan)

## 刷机后如何快速开始
- 连接终端
  - 使用网络(推荐) 
    - 使用KlipperScreen连接到你的局域网
    - 网络浏览器输入`你手机的ip地址:8888`即可，例如`192.168.31.124:8888`
  - 使用usb串口
    - usb线缆连接到你的电脑，你的电脑将识别到串口设备。
    - 使用`PuTTY`或其它终端软件进入终端控制台。

- 利用otg插头连接到你的3D打印机主板
   - 在命令行中使用`lsusb`命令，确保系统识别到了你的3D打印机主板。
     - 常见的主板会显示为`Qingheng`, `OpenMoko xxx`等。
     - 如果没有识别到的话，请检查你的线缆连接情况。
   - 为你的3D打印机主板安装Klipper固件。
     - 安装交叉编译器

           sudo apt update
           sudo apt install avrdude gcc-avr binutils-avr avr-libc stm32flash libnewlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi pkg-config
      
      - 参考[Klipper文档](https://www.klipper3d.org/zh/Installation.html) 为你的主板编译安装Klipper固件
  
- 设置3D打印机的配置文件
    - 向你的打印机主板销售方索取，或在[Klipper仓库](https://github.com/Klipper3d/klipper/tree/master/config)中寻找你主板型号的配置文件。
    - 打开`Fluidd`界面，你可以用网页浏览器访问`你手机的ip地址`打开。
    - 在左侧的`配置`选项卡中，将你的主板配置文件重命名为`printer.cfg`并覆盖原始的文件。
    - 在`printer.cfg`的末尾填入 `[include fluidd.cfg]`

- 此时你就完成了简单的配置工作，享受吧！

## 将你的手机改装为直流供电（PCB）

- [Xiaomi Redmi 2 (wt88047)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi2)
- [Xiaomi Redmi Note 4x (xiaomi-mido)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi_Note4x)
- [Xiaomi Redmi 4 Prime(xiaomi-markw)](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi4_Prime)
- [Xiaomi Note 2](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB/Xiaomi_redmi4_Prime)

## 常见问题及解决方案：
- [启用和设置CAN](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/CAN_BUS_CN.md)
- 归零时发生错误 `timer too close`
  - 如果你是高通625机型，关闭Klipper设置中的CPU温度监测
- [`lsusb`没有任何反应](https://github.com/umeiko/KlipperPhonesLinux/tree/main/PCB)
- [旋转屏幕](https://github.com/umeiko/KlipperPhonesLinux/blob/main/Docs/Q%26A/ROTATE_THE_SCREEN_CN.md)
- [想要自己编译Linux内核](https://gitee.com/meiziyang2023/ubuntu-ports-xiaomi-625-phones)

## 感谢
- [PostmarketOS](https://postmarketos.org/)
- [Klipper](https://github.com/Klipper3d/)
- [KlipperScreen](https://github.com/KlipperScreen/KlipperScreen)
- [fluidd](https://github.com/fluidd-core/fluidd)
- [moonraker](https://github.com/Arksine/moonraker)
