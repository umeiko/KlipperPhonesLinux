sudo mount root.img /mnt/chroot

sudo mount --bind /proc /mnt/chroot/proc
sudo mount --bind /dev /mnt/chroot/dev
sudo mount --bind /dev/pts /mnt/chroot/dev/pts
sudo mount --bind /sys /mnt/chroot/sys

sudo cp /etc/resolv.conf /mnt/chroot/etc/
sudo cp /etc/hosts /mnt/chroot/etc/

rm /mnt/chroot/tmp/linux-*.deb 
cp linux-* /mnt/chroot/tmp
cp chroot_install_kernel* /mnt/chroot/tmp/install_kernel.sh

sudo chroot /mnt/chroot
