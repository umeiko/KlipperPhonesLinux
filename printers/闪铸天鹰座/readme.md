![QQ截图20240926000232](https://github.com/user-attachments/assets/d2960292-8516-4052-bca8-675f8ff96824)


![微信图片_20240926152146](https://github.com/user-attachments/assets/7d45e980-8508-4cae-ab30-5a80a0a62713)

这个cpu有两种不同主频的，看情况编译正确符合你主板的那个

Q：How to upgrade the firmwares?

A： 
 1. Insert the TF card into the card reader
 2. Insert the card reader into the USB interface of the computer
 3. Create a new folder named firmware in TF card
 4. Copy the xx.bin file into the "firmware" folder
 5. Insert the TF card into the TF card socket of the machine
 6. Restart the machine


Q：如何升级固件？

A： 

0. 在已经编译完成固件后，在`~/klipper/out`中下载 klipper.bin
1. 将 TF (建议16G以下，太大了不认卡，FAT、FAT32格式)卡插入读卡器 
2. 将读卡器插入电脑的 USB 接口 
3. 在 TF 卡中新建一个文件夹，名为firmware 
4. 将 xx.bin 文件复制到“firmware”文件夹中
5. 将 TF 卡插入机器的 TF 卡座 
6. 重新启动机器

这个主板的相关信息：
![Aquila主板图纸(纠错24 9 19) (1)](https://github.com/user-attachments/assets/0d2d655c-6305-4c82-b320-4ccaa67d5ee0)

