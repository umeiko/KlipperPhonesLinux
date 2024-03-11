## 小米5
如果强解BL锁，会导致gpu驱动无法加载，实测可通过屏蔽GPU解决

`sudo systemctl disable xwayland_ks`
`sudo systemctl enable KlipperScreen`
`sudo nano /etc/X11/xorg.conf.d/00-rotate.conf`

加入以下字段：

    Section "Device"
        Identifier "Card0"
        Driver "simplefb"
        Option "AccelMethod" "none"
    EndSection

即可正常使用屏幕


打开`/etc/modprobe.d/touchscreens-workaround.conf`添加以下字段强行规定网络驱动加载顺序修复网络问题

    softdep rmtfs_mem pre: ath
    softdep ath pre: ath10k_core
    softdep ath10k_core pre: ath10k_pci
    softdep ath10k_pci pre: cfg80211
    softdep cfg80211 pre: mac80211



如没有网络，尝试重新加载网络驱动 ?

`sudo rmmod ath`
`sudo rmmod mac80211`
`sudo rmmod cfg80211`
`sudo modprobe ath10k_pci`
`sudo modprobe ath10k_core`
`sudo modprobe ath`
`sudo modprobe cfg80211`
