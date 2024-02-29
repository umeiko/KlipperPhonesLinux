source ./env.sh

echo $CROSS_COMPILE
echo $ARCH
echo $CC

cd ./linux
make clean
rm -r ./debian
make -j$(nproc)
fakeroot make-kpkg  --initrd --cross-compile aarch64-linux-gnu- --arch arm64 kernel_image kernel_headers
cd ..

# ./umount_rootfs.sh
# ./mount_rootfs.sh

