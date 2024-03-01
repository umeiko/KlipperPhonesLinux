# 没有你的机型？自己移植一个

- 更新中
- 可参考[PostmarketOS Devices](https://wiki.postmarketos.org/wiki/Devices)

## 移植过程（以msm8953-mido为例） 

移植需要在`Ubuntu20.24`系统下进行

1. 克隆本仓库，进入本仓库的编译文件夹中。
        
        git clone https://github.com/umeiko/KlipperPhonesLinux.git --depth 1
        cd ./KlipperPhonesLinux/LinuxKernels/scripts

2. 运行`init.sh`安装下载依赖, 将正确的linux内核源码（这里用msm8953-mainline作为示例）, 内核配置文件（这里用msm8953-mainline作为示例）复制到本目录中, 运行`menuconfig.sh`配置你需要的内核功能（不知道想要修改什么的话就直接退出就可以） 运行`full_compile.sh`进行内核编译
        
       ./init.sh
       git clone https://github.com/msm8953-mainline/linux --depth 1
       cp ../msm8953/.config ./linux
       menuconfig.sh
       ./full_compile.sh

4. 下载本仓库提供的klipperos_base_rootfs.zip, 将其解压后命名为root.img放置在本目录下

        wget https://github.com/umeiko/KlipperPhonesLinux/releases/download/base_rootfs/klipperos_base_rootfs.zip
        unzip klipperos_base_rootfs.zip

5. 通过chroot进入刷机包文件系统中进行内核安装。

        ./mount_rootfs.sh
        cd /tmp
        ./install_kernel.sh
        exit

6. 将小米625机型的固件拷贝到文件系统中，从而启用其联网功能与GPU驱动。其它型号机型的固件可以在Postmarekt OS项目中找到。

        sudo cp -r ../msm8953/firmware/* /mnt/chroot/lib/firmware/

7. 根据后文“刷机包对应机型的移植说明”，修改`get_kernel_files.sh`和`./mkboot.sh`生成刷机包

       ./get_kernel_files.sh
       ./mkboot.sh

8. 解除刷机包挂载，清理内存
        ./umount_rootfs.sh

9. 刷机包`boot.img` `rootfs.img` 出现在了 `./tmp_mkboot` 文件夹中，拿去刷机即可~

## 刷机包对应机型的移植说明

1. 设备树文件会在编译完毕后出现在内核源码目录下的`arch/arm64/boot/dts/qcom/`中。你需要更改`get_kernel_files.sh`中相应复制设备树行的通配符来得到你所需要机型的设备树文件，例如红米Note4x代号为`mido`，于是该文件第三行是`cp ./linux/arch/arm64/boot/dts/qcom/*mido*.dtb ./tmp_mkboot/`。



## 已知问题

1. 安装[pmbootstrap](https://wiki.postmarketos.org/wiki/Pmbootstrap) 会导致`chroot`命令出错，且暂时没有解决方案，删除后也无法恢复，只能重装系统。所以，如果你想要使用，请在另外的容器中使用[pmbootstrap](https://wiki.postmarketos.org/wiki/Pmbootstrap)。

