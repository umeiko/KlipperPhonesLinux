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

####检查与准备工作
请不要做Fly文档中的`3.1 非FLY上位机检测` ! ! 红米已经完成相关配置！

```
SHT36预装了CanBoot，支持CAN烧录，烧录前请使用CAN连接到上位机；
请注意 canboot默认速率为500k
```
虽然这么说，但是还是推荐先刷入CanBoot固件，避免SHT36其实没有预装，或者默认速率并不对。
红米上位机默认速率也是500K。如果你的CanBoot不是500K的话则需要修改上位机的速率。
通过 `红米IP:8888`可以直接从浏览器进入SSH。手机，平板电脑等都支持，不一定需要电脑
按照如下填写即可连接。
![image](https://github.com/user-attachments/assets/bade9a1c-5514-4f77-acd0-5def942956c7)

连接后，输入如下命令来修改红米的CAN速率

    sudo nano /home/auto_can_up.sh
这个命令会打开一个文本编辑器，在这里对CAN配置文件做出修改。
图中指出的地方为你需要的速率，两处的速率需要一致。修改完成后，`ctrl+O` 保存，`ctrl+X` 退出编辑器。
![image](https://github.com/user-attachments/assets/a1e6ad50-c4e5-4c6f-bf09-d9a9b8c6af28)

执行`make`命令编译固件前你需要安装交叉编译器，交叉编译器由于占用`3GB`空间所以被精简了，所以你安装前也要确保上位机存储空间充足。
你可以运行

    sudo update  &&  sudo apt install avrdude gcc-avr binutils-avr avr-libc stm32flash libnewlib-arm-none-eabi gcc-arm-none-eabi binutils-arm-none-eabi pkg-config
来完成交叉编译器的安装。请确定安装成功，而不是出现报错。如果则是因为你的的网络质量不佳导致，请确保上位机有可靠的互联网连接。
#### 1. 刷入CanBoot固件
首先编译固件。请确保文件路径正确！确保你用户身份是`umeko`,千万不要是`root`！！！！！

    cd ~
    cd klipper
    make clean
    make menuconfig
按照下图的配置来输入
![image](https://github.com/user-attachments/assets/33228d2d-6e27-4d0a-b797-a87160e83d8d)

完成后，按 `esc` 后 按 `y` 确认
接下来输入如下命令来编译固件

    make -j$(nproc)

输出如果为
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
