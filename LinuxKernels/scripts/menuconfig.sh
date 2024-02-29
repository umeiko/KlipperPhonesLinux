source ./env.sh

echo $CROSS_COMPILE
echo $ARCH
echo $CC

cd ./linux
make menuconfig