#!/bin/bash

sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz wget && \
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.54.tar.xz && \
sudo tar -xvpf linux-6.12.54.tar.xz --xattrs-include='*.*' --numeric-owner && \
cd linux-6.12.54 && \
sudo make clean -j64 && \
sudo make mrproper -j64 && \
sudo make defconfig -j64;

#DESATIVAR SWAP
sudo sed -Ei '/CONFIG_SWAP/ s/.*(CONFIG_SWAP[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR ZSWAP
sudo sed -Ei '/CONFIG_ZSWAP/ s/.*(CONFIG_ZSWAP[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR ZRAM
sudo sed -Ei '/CONFIG_ZRAM/ s/.*(CONFIG_ZRAM[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR MITIGATIONS
sudo sed -Ei '/CONFIG_MITIGATION/ s/.*(CONFIG_MITIGATION[A-Z0-9_]*).*/\1=n/' config;
sudo sed -Ei '/CONFIG_CPU_MITIGATIONS/ s/.*(CONFIG_CPU_MITIGATIONS[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR WATCHDOG
sudo sed -Ei '/CONFIG_WATCHDOG/ s/.*(CONFIG_WATCHDOG[A-Z0-9_]*).*/\1=n/' config;
#CONFIG_SOFT_WATCHDOG=m
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
#CONFIG_CROS_EC_WATCHDOG=m
#CONFIG_DA9052_WATCHDOG=m
#CONFIG_DA9055_WATCHDOG=m
#CONFIG_DA9063_WATCHDOG=m
#CONFIG_DA9062_WATCHDOG=m
#CONFIG_LENOVO_SE10_WDT=m
#CONFIG_LENOVO_SE30_WDT=m
#CONFIG_MENF21BMC_WATCHDOG=m
#CONFIG_MENZ069_WATCHDOG=m
#CONFIG_WDAT_WDT=m
#CONFIG_WM831X_WATCHDOG=m
#CONFIG_WM8350_WATCHDOG=m
#CONFIG_XILINX_WATCHDOG=m
#CONFIG_ZIIRAVE_WATCHDOG=m
#CONFIG_RAVE_SP_WATCHDOG=m
#CONFIG_MLX_WDT=m
#CONFIG_CADENCE_WATCHDOG=m
#CONFIG_DW_WATCHDOG=m
#CONFIG_TWL4030_WATCHDOG=m
#CONFIG_MAX63XX_WATCHDOG=m
#CONFIG_RETU_WATCHDOG=m
#CONFIG_ACQUIRE_WDT=m
#CONFIG_ADVANTECH_WDT=m
#CONFIG_ADVANTECH_EC_WDT=m
#CONFIG_ALIM1535_WDT=m
#CONFIG_ALIM7101_WDT=m
#CONFIG_CGBC_WDT=m
#CONFIG_EBC_C384_WDT=m
#CONFIG_EXAR_WDT=m
#CONFIG_F71808E_WDT=m
#CONFIG_SP5100_TCO=m
#CONFIG_SBC_FITPC2_WATCHDOG=m
#CONFIG_EUROTECH_WDT=m
#CONFIG_IB700_WDT=m
#CONFIG_IBMASR=m
#CONFIG_WAFER_WDT=m
#CONFIG_I6300ESB_WDT=m
#CONFIG_IE6XX_WDT=m
#CONFIG_INTEL_OC_WATCHDOG=m
#CONFIG_ITCO_WDT=m
#CONFIG_ITCO_VENDOR_SUPPORT=y
#CONFIG_IT8712F_WDT=m
#CONFIG_IT87_WDT=m
#CONFIG_HP_WATCHDOG=m
#CONFIG_HPWDT_NMI_DECODING=y
#CONFIG_KEMPLD_WDT=m
#CONFIG_SC1200_WDT=m
#CONFIG_PC87413_WDT=m
#CONFIG_NV_TCO=m
#CONFIG_60XX_WDT=m
#CONFIG_SMSC_SCH311X_WDT=m
#CONFIG_SMSC37B787_WDT=m
#CONFIG_TQMX86_WDT=m
#CONFIG_VIA_WDT=m
#CONFIG_W83627HF_WDT=m
#CONFIG_W83877F_WDT=m
#CONFIG_W83977F_WDT=m
#CONFIG_MACHZ_WDT=m
#CONFIG_SBC_EPX_C3_WATCHDOG=m
#CONFIG_INTEL_MEI_WDT=m
#CONFIG_NI903X_WDT=m
#CONFIG_NIC7018_WDT=m
#CONFIG_SIEMENS_SIMATIC_IPC_WDT=m
#CONFIG_MEN_A21_WDT=m

#DESATIVAR SUSPENSAO
sudo sed -Ei '/CONFIG_SUSPEND/ s/.*(CONFIG_SUSPEND[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR HIBERNACAO
sudo sed -Ei '/CONFIG_HIBERNATE/ s/.*(CONFIG_HIBERNATE[A-Z0-9_]*).*/\1=n/' config;

#DESATIVAR FORMATO DE ARQUIVOS EXT2
sudo sed -i 's/^.*CONFIG_EXT2.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS EXT3
sudo sed -i 's/^.*CONFIG_EXT3.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS JFS
sudo sed -i 's/^.*CONFIG_JFS.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS XFS
sudo sed -i 's/^.*CONFIG_XFS.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS GFS2
sudo sed -i 's/^.*CONFIG_GFS2.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS BTRFS
sudo sed -i 's/^.*CONFIG_BTRFS.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS NILFS2
sudo sed -i 's/^.*CONFIG_NILFS2.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS F2FS
sudo sed -i 's/^.*CONFIG_F2FS.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS BCACHEFS
sudo sed -i 's/^.*CONFIG_BCACHEFS.*$/#/' .config;

#DESATIVAR FORMATO DE ARQUIVOS NTFS
sudo sed -i 's/^.*CONFIG_NTFS.*$/#/' .config;

#DESATIVAR RANDOMIZAÇÃO DE MEMORIA
sudo sed -i 's/^.*CONFIG_RANDOMIZE.*$/#/' .config;

#DESATIVAR DEBUG
sudo sed -i 's/^.*CONFIG_DEBUG.*$/#/' .config;

#DESATIVAR KASAN
sudo sed -i 's/^.*CONFIG_KASAN.*$/#/' .config;

#DESATIVAR HYPERV
sudo sed -i 's/^.*CONFIG_HYPERV.*$/#/' .config;
sudo sed -i 's/^.*CONFIG_MSHV_ROOT.*$/#/' .config;

#DESATIVAR AUDIT
sudo sed -i 's/^.*CONFIG_AUDIT.*$/#/' .config;

#DESATIVAR SELINUX
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX.*$/#/' .config;

#DESATIVAR XEN
sudo sed -i 's/^.*CONFIG_XEN.*$/#/' .config;
sudo sed -i 's/^.*CONFIG_SWIOTLB_XEN.*$/#/' .config;

#DESATIVAR DRIVERS DE LEDS
sudo sed -i 's/^.*CONFIG_LEDS.*$/#/' .config;

# DESATIVAR SUPORTE BLUETOOTH
sudo sed -i 's/^.*CONFIG_BT.*$/#/' .config;

# SISTEMA DE ARQUIVOS CD-ROM E DVD
sudo sed -i 's/^.*CONFIG_ISO9660_FS.*$/#/' .config;
sudo sed -i 's/^.*CONFIG_JOLIET.*$/#/' .config;
sudo sed -i 's/^.*CONFIG_ZISOFS.*$/#/' .config;
sudo sed -i 's/^.*CONFIG_UDF_FS.*$/#/' .config;

sudo make -j64 && \
sudo make modules_install -j64 && \
sudo make install -j64 && \
sudo mv arch/x86/boot/bzImage /boot/vmlinuz-6.12.54 && \
sudo mkinitcpio -k $(make -s kernelversion) -g /boot/initramfs-6.12.54.img && \
sudo mkinitcpio -P && \
sudo grub-mkconfig -o /boot/grub/grub.cfg
