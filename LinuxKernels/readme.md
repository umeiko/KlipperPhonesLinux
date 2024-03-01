# Porting Guide
[中文文档](./README_CN.md)

- In progress
- Refer to [PostmarketOS Devices](https://wiki.postmarketos.org/wiki/Devices)

## Porting Process (Using msm8953-mido as an example)

Porting should be done on the `Ubuntu 20.24` system.

1. Clone this repository and enter the compilation folder.

    ```bash
    git clone https://github.com/umeiko/KlipperPhonesLinux.git --depth 1
    cd ./KlipperPhonesLinux/LinuxKernels/scripts
    ```

2. Run `init.sh` to install dependencies, copy the correct Linux kernel source (using msm8953-mainline as an example), and kernel configuration file (using msm8953-mainline as an example) to this directory. Run `menuconfig.sh` to configure the kernel features you need (if you don't know what to modify, you can simply exit to use the default configuration). Then, run `full_compile.sh` for kernel compilation.

    ```bash
    ./init.sh
    git clone https://github.com/msm8953-mainline/linux --depth 1
    cp ../msm8953/.config ./linux
    ./menuconfig.sh
    ./full_compile.sh
    ```

3. Download the klipperos_base_rootfs.zip provided by this repository, unzip it, and rename it as root.img placing it in the current directory.

    ```bash
    wget https://github.com/umeiko/KlipperPhonesLinux/releases/download/base_rootfs/klipperos_base_rootfs.zip
    unzip klipperos_base_rootfs.zip
    ```

4. Chroot into the firmware file system for kernel installation.

    ```bash
    ./mount_rootfs.sh
    cd /tmp
    ./install_kernel.sh
    exit
    ```

5. Copy the firmware of Xiaomi 625 model to the file system to enable its networking function and GPU driver. Firmware for other models can be found in the Postmarket OS project.

    ```bash
    sudo cp -r ../msm8953/firmware/* /mnt/chroot/lib/firmware/
    ```

6. Modify `get_kernel_files.sh` and `./mkboot.sh` according to the "Porting Instructions for the Corresponding Model in the Flash Package" section below to generate the flash package.

    ```bash
    ./get_kernel_files.sh
    ./mkboot.sh
    ```

7. Unmount the flash package and clean up memory.

    ```bash
    ./umount_rootfs.sh
    ```

8. The flash package `boot.img` and `rootfs.img` can be found in the `./tmp_mkboot` folder, ready to be flashed.

## Porting Instructions for the Corresponding Model in the Flash Package

1. The device tree file will appear in the kernel source directory after compilation under `arch/arm64/boot/dts/qcom/`. You need to change the wildcard in the third line of the `get_kernel_files.sh` file to copy the device tree file for your specific model. For example, for the Redmi Note 4x with the code name `mido`, the third line of the file would be `cp ./linux/arch/arm64/boot/dts/qcom/*mido*.dtb ./tmp_mkboot/`.

## Known Issues

1. Installing [pmbootstrap](https://wiki.postmarketos.org/wiki/Pmbootstrap) may cause an error with the `chroot` command, and there is currently no solution. Removal does not restore the system; reinstalling is the only option. If you want to use it, please use [pmbootstrap](https://wiki.postmarketos.org/wiki/Pmbootstrap) in another container.
