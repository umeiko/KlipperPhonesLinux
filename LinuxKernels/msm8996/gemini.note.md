# 小米5移植过程中遇到的问题和解决方案
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

## 修复启动时随机没有网络的情况
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

### 有人认为`qca`蓝牙启动影响了`ath`驱动的加载导致无网络
参考[这个讨论](https://bbs.archlinux.org/viewtopic.php?id=281292)
尝试编译了禁用蓝牙的内核 *无效，看来不是这个原因*

        Symbol: BT_HCIUART_QCA [=n]                                                                                                                                                      │  
          │ Type  : bool                                                                                                                                                                 │  
          │ Defined at drivers/bluetooth/Kconfig:228                                                                                                                                     │  
          │   Prompt: Qualcomm Atheros protocol support                                                                                                                                  │  
          │   Depends on: NET [=y] && BT [=n] && BT_HCIUART [=n] && BT_HCIUART_SERDEV [=n]                                                                                               │  
          │   Location:                                                                                                                                                                  │  
          │     Main menu                                                                                                                                                                │  
          │       -> Networking support (NET [=y])                                                                                                                                       │  
          │ (1)     -> Bluetooth subsystem support (BT [=n])                                                                                                                             │  
          │           -> Bluetooth device drivers                                                                                                                                        │  
          │ Selects: BT_HCIUART_H4 [=n] && BT_QCA [=n]
          

## 修复随机出现的启动卡米，黑屏情况
定位到是因为`adsp`加载与其它内核组件冲突引起的。因为小米Note2也有[同样的问题](https://gitlab.com/postmarketOS/pmaports/-/merge_requests/2283)。
移除`adsp`驱动即可。

    sudo rm /lib/firmware/qcom/msm8996/gemini/adsp.mbn


## 某些小米5屏幕黑屏始终无法点亮，是因为屏幕型号问题
`lgd-fhd-td4322`暂时不存在于[msm8996屏幕驱动](https://gitlab.com/msm8996-mainline/linux/-/tree/msm8996-staging/drivers/gpu/drm/panel)中
[小米官方开源仓库](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/commit/c0379aae3d784d78f304ae6de13ce522f4bbd4cc#diff-b79aee18a3f77cb7324a7b95f5b43684ac64b89299e15b0af894371eff19a2e8R89)中可以找到这款芯片的存在。
[lgd-fhd-td4322下游设备树](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/c0379aae3d784d78f304ae6de13ce522f4bbd4cc/arch/arm/boot/dts/qcom/dsi-panel-lgd-fhd-td4322-cmd.dtsi)

### 解决方案：

- `msm8916-mainline linux-panel-drivers`
- `lk2nd/device/dts/msm8996/msm8996-xiaomi-capricorn.dts`


        // SPDX-License-Identifier: BSD-3-Clause
        #include <skeleton64.dtsi>
        #include <lk2nd.dtsi>
        
        / {
                model = "Xiaomi Mi 5s";
                qcom,msm-id = <305 0x10000>;
                qcom,board-id = <37 0>;
                //qcom,pmic-id = <0x20009 0x10013 0x0 0x0>;
        };
        
        &lk2nd {
                model = "Xiaomi Mi 5s";
                compatible = "xiaomi,capricorn";
        };

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
