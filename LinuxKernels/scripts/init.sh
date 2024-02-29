echo "正在安装依赖，请确保系统为Ubuntu20.04"
sudo apt install binfmt-support qemu-user-static gcc-10-aarch64-linux-gnu kernel-package fakeroot simg2img img2simg mkbootimg bison flex gcc-aarch64-linux-gnu pkg-config libncurses-dev libssl-dev unzip git

# echo "正在下载内核源码(6.7.5)"
# git clone https://gitee.com/meiziyang2023/linux.git

# echo "拷贝内核配置文件"
# cp ./.config ./linux/.config

sudo mkdir /mnt/chroot