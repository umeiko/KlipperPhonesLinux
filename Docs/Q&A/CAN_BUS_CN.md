
[中文文档](./CAN_BUS_CN.md)
# CAN 板是什么
- CAN板可以理解为打印机的另一块下位机主板，和你本身的下位机主板属于同级别的关系。
和下位机的区别是，CAN板使用CAN协议与上位机通信，普通下位机使用UART协议与上位机通信。

```
LINUX上位机
  ├── USB 1
  │   └── U2C (usb-to-can)
  │       └── CAN-工具头
  ├── USB 2
  │   └── USB转串口模块
  │       └── 打印机主板
  ├── USB 3
  │   └── 摄像头
  └──  ...
```


# CAN 的实现原理是什么
- 在STM32，树莓派rp2040中，CAN通信是使用 程序 驱动两个GPIO实现的。
	因此没有预先烧录相应 程序 时，CAN板的CAN口是不具备任何功能的。


# 要使用 CAN 前板需要做什么
-  烧录CANBOOT固件。这一步通过USB，或者下载器给CAN板写入程序，使得CAN板可以通过CAN接口进行通信。
-  使用CAN烧录Klipper固件。这一步通过CAN总线，将Klipper固件烧录到CAN板中。
	注意：通信比特率并不是越高越好，相反，越低的比特率抗干扰性反而越强。一般建议500K~100K之间

# 不同的CAN主控烧录的方法有什么不同
- rp2040，烧录CANBOOT一般利用Windows电脑，将固件拖入虚拟的U盘中即可。
- STM32，烧录的方法非常多，生成固件后，利用DFU，USB，CDC，STlink下载器等等都可以，和一般的STM32开发板没有什么区别。

## 利用linux系统烧录STM32的DFU模式可能遇到的问题：
- `No DFU capable USB device available.` 可以尝试将固件拷贝到Windows电脑中使用DFU来下载程序。
	Windows下DFU驱动下载：https://zadig.akeo.ie/



# 在Klipper-Phone-Linux中配置CAN
刷机包支持CAN启用使用！
本上位机系统已启用CAN模块，配置好【自动启动CAN】和【插拔自动启动CAN】，请不要再配置相关设置。
- 修改合适的CAN参数（修改后请【断电】重启打印机）

        sudo nano /home/auto_can_up.sh

找到相应的命令行更改你想要的can配置, 例如`bitrate`和`quelen`


- 使用如下命令查看CAN设备id：

        ~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
例如：
出现`Found canbus_uuid=11aa22bb33cc`则查找到设备ID
其中`11aa22bb33cc`为设备UUID，可直接填入klipper配置文件
如果没有出现ID或报错请认真阅读文档并检查接线


- 在主板配置中相应位置配置你自己的CAN的id
例如：

        [mcu sht36v2] # 工具主板序列号
        canbus_uuid: e51d5c71a901

就可以了，就这么简单！排查错误常用方法：`lsusb`，确保系统真的识别到了你的u2oc模块。
