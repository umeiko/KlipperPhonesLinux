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

## 某些小米5屏幕黑屏，是因为屏幕型号问题
`lgd-fhd-td4322`暂时不存在于[msm8996屏幕驱动](https://gitlab.com/msm8996-mainline/linux/-/tree/msm8996-staging/drivers/gpu/drm/panel
)中
[小米官方开源仓库](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/commit/c0379aae3d784d78f304ae6de13ce522f4bbd4cc#diff-b79aee18a3f77cb7324a7b95f5b43684ac64b89299e15b0af894371eff19a2e8R89)中可以找到这款芯片的存在。

## 不这么做也可以驱动，这里仅做记录
根据主线社区的建议，将GPU固件加入initrmfs中来确保屏幕能够正常工作；`/usr/share/initramfs-tools/hooks/qcom-firmware`

    #!/bin/sh
    set -e

    PREREQS=""
    case $1 in
        prereqs) echo "${PREREQS}"; exit 0;;
    esac
    version=0

    . /usr/share/initramfs-tools/hook-functions

    add_firmware qcom/msm8996/gemini/a530_zap.mbn
    add_firmware qcom/a530_pm4.fw
    add_firmware qcom/a530_pfp.fw
    add_firmware qcom/a530v3_gpmu.fw2
