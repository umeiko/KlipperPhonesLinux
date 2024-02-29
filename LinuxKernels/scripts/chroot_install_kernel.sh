dpkg --get-selections | grep linux
dpkg -l | grep -E "linux-headers|linux-image" |awk '{print $2}'|xargs dpkg -P
rm -rf /lib/modules/*

dpkg -i linux*.deb
dpkg --get-selections | grep linux

ls /lib/modules
