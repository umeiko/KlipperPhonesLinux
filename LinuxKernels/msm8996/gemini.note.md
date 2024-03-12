# 小米5注意事项
## 强解手机的修复显示
如果强解BL锁，会导致gpu驱动无法加载，实测可通过屏蔽GPU解决

        sudo systemctl disable xwayland_ks
        sudo systemctl enable KlipperScreen
        sudo nano /etc/X11/xorg.conf.d/00-rotate.conf

加入以下字段：

    Section "Device"
        Identifier "Card0"
        Driver "simplefb"
        Option "AccelMethod" "none"
    EndSection

即可正常使用屏幕

## 修复启动时随机黑屏/随机没有网络的情况
打开`/etc/modprobe.d/touchscreens-workaround.conf`添加以下字段强行规定网络驱动加载顺序修复网络问题

        softdep drm pre: panel_jdi_fhd_r63452
        softdep panel_jdi_fhd_r63452 pre: rmtfs_mem
        softdep ath pre: ath10k_core
        softdep ath10k_core pre: ath10k_pci
        softdep ath10k_pci pre: cfg80211
        softdep cfg80211 pre: mac80211
        softdep mac80211 pre: rmtfs_mem

打开`/home/auto_resize_script.sh`在末尾添加以下字段重扫pci总线进一步确保`wlan驱动`正确加载

    sleep 30
    echo 1 > /sys/class/pci_bus/0000\:01/rescan


