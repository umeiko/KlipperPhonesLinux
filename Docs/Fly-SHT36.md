## 用红米上位机连接配置SHT36的过程

官方文档在[这里](https://mellow.klipper.cn/#/board/fly_shtadxl/README)。本教程展示了一次配置的过程。

### 电气连接

这一步参考fly文档即可，不再赘述。
连接方法：

    红米 <---USB--- UTOC <---CAN线缆--- Fly-SHT36
    或者
    红米 <---USB--- 主板(带CAN桥接固件) <---CAN线缆--- Fly-SHT36

本教程只提供Fly-SHT36的连接过程。打印机主板与桥接固件等请与主板厂商客服沟通。
可以执行

    lsusb
命令来检查系统有没有识别到U2OC模块

![image](https://github.com/user-attachments/assets/81536b19-9e1f-4085-a8ae-5361e698bb43)

### 配置

#### 检查与准备工作
请不要做Fly文档中的`3.1 非FLY上位机检测` ! ! 红米已经完成相关配置！

```
SHT36预装了CanBoot，支持CAN烧录，烧录前请使用CAN连接到上位机；
请注意 canboot默认速率为500k
```
虽然这么说，但是还是推荐先刷入CanBoot固件，避免SHT36其实没有预装，或者默认速率并不对。（我手上这块实际到手是1M，不是文档中的500K）
红米上位机默认速率也是500K。如果你的CanBoot不是500K的话则需要修改上位机的速率。
通过 `红米IP:8888`可以直接从浏览器进入SSH。手机，平板电脑等都支持，不一定需要电脑
按照如下填写即可连接。

![image](https://github.com/user-attachments/assets/bade9a1c-5514-4f77-acd0-5def942956c7)

连接后，输入如下命令来修改红米的CAN速率

    sudo nano /home/auto_can_up.sh
这个命令会打开一个文本编辑器，在这里对CAN配置文件做出修改。
图中指出的地方为你需要的速率，两处的速率需要一致。修改完成后，`ctrl+O` 后`回车`保存，`ctrl+X` 退出编辑器。将整个打印机全部断电重启后修改即可生效。（只重启上位机不行）

![image](https://github.com/user-attachments/assets/a1e6ad50-c4e5-4c6f-bf09-d9a9b8c6af28)

执行`make`命令编译固件前你需要安装交叉编译器，交叉编译器由于占用`3GB`空间所以被精简了，所以你安装前也要确保上位机存储空间充足。
你可以运行

    sudo update  &&  sudo apt install avrdude gcc-avr binutils-avr avr-libc stm32flash libnewlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi pkg-config
来完成交叉编译器的安装。请确定安装成功，而不是出现报错。如果则是因为你的的网络质量不佳导致，请确保上位机有可靠的互联网连接。
#### 1. 刷入CanBoot固件
首先编译固件。请确保文件路径正确！确保你用户身份是`umeko`,千万不要是`root`！！！不要擅自使用`sudo`命令！！

    cd ~
    cd klipper
    make clean
    make menuconfig
按照下图的配置来输入

![image](https://github.com/user-attachments/assets/33228d2d-6e27-4d0a-b797-a87160e83d8d)

完成后，按 `esc` 后 按 `y` 确认
接下来输入如下命令来编译固件

    make -j$(nproc)

输出如果为类似
```bash
Version: v0.12.0-652-g44106eca
  Linking out/klipper.elf
  Creating uf2 file out/klipper.uf2
```
则成功编译了。点击顶部的 `文件管理` 按钮，从下图中的位置将它下载到你的电脑里。

![image](https://github.com/user-attachments/assets/0fcb770b-fd1b-4a03-8df1-d7c28ed1037c)

根据Fly教程中的方法将这个文件`klipper.uf2`烧录到SHT36中。

![image](https://github.com/user-attachments/assets/688ed1a5-3a74-45bd-8997-29d61a2e3d17)

#### 2. 刷入Klipper固件
首先输入

    python3 ~/klipper/lib/canboot/flash_can.py -q
来检查是否连接到了`SHT36`。如果没问题应该有类似这样的输出。如果没有的话则从`lsusb`开始重做。并检查电气连接是否正常，比特率是不是设置错了（`红米`的和`SHT36`的必须一致），CAN的`通讯电阻`有没有弄好。

```bash
umeko@umeko-hm2:~$ python3 ~/klipper/lib/canboot/flash_can.py -q
Resetting all bootloader node IDs...
Checking for canboot nodes...
Detected UUID: 0ef7960f64d6, Application: CanBoot
Query Complete
```
记录下这里的`0ef7960f64d6`后续烧录需要
接下来继续编译`Klipper固件`。请确保文件路径正确！确保你用户身份是`umeko`,千万不要是`root`，不要擅自使用`sudo`命令！！

    cd ~
    cd klipper
    make clean
    make menuconfig
按照下图的配置来输入

![image](https://github.com/user-attachments/assets/00320cd4-a219-499b-894f-9b65284c4754)

完成后，按 `esc` 后 按 `y` 确认

接下来输入如下命令来编译固件

    make -j$(nproc)
输出如果为类似
```bash
Version: v0.12.0-652-g44106eca
  Linking out/klipper.elf
  Creating bin file out/klipper.bin
```
则成功编译了。
输入如下命令来烧录固件

    python3 ~/klipper/lib/canboot/flash_can.py -u 0ef7960f64d6
其中这里的`0ef7960f64d6`是之前`python3 ~/klipper/lib/canboot/flash_can.py -q`中查到的canboot地址。你需要替换成你自己的。
看到类似的输出
```bash
umeko@umeko-hm2:~/klipper$ python3 ~/klipper/lib/canboot/flash_can.py -u 0ef7960f64d6
Sending bootloader jump command...
Resetting all bootloader node IDs...
Checking for canboot nodes...
Detected UUID: 0ef7960f64d6, Application: CanBoot
Attempting to connect to bootloader
CanBoot Connected
Protocol Version: 1.0.0
Block Size: 64 bytes
Application Start: 0x10004000
MCU type: rp2040
Verifying canbus connection
Flashing '/home/umeko/klipper/out/klipper.bin'...

[##################################################]

Write complete: 123 pages
Verifying (block count = 490)...

[##################################################]

Verification Complete: SHA = 90190F3EFB96F39C5F0530ACA7C231C99D87A2D1
CAN Flash Success
```
则烧录成功了。重启打印机。

开机后运行`python3 ~/klipper/lib/canboot/flash_can.py -q`来看看有没有成功。下图为成功的样子

![image](https://github.com/user-attachments/assets/7ff10fbb-e944-4665-bc5a-921ef7ab4230)

如果失败的话则好好检查，你上位机和下位机编译固件的比特率是不是真的是一致的。

在你的配置文件中（`printer.cfg`或者是`can.cfg`之类的，反正`.cfg`结尾）填入CAN板的UUID即可

```bash
[mcu sht36]
canbus_uuid: 0ef7960f64d6     #将读取到的uuid填写到此处
```

现在就完成了与can板的基本连接，接下来的流程都为常规配置，和Fly售后交流即可。
[参考这里](https://mellow.klipper.cn/#/board/fly_sht_v2/cfg)
![image](https://github.com/user-attachments/assets/2877dfbf-319d-49fd-af28-3ae97d7fcc0a)
