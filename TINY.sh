#!/bin/bash
set -e
trap 'echo "FALHOU no comando: $BASH_COMMAND"' ERR
clear;

wget -P /KERNEL https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.11.tar.xz && \
tar xvpf /KERNEL/linux-*.tar.xz -C /KERNEL --xattrs-include="*.*" --numeric-owner > /dev/null 2>&1 && \
rm -rf /KERNEL/linux-*.tar.xz && \
make -C /KERNEL/linux-* tinyconfig > /dev/null 2>&1 && \
cd /KERNEL/linux-*;
# Base do sistema
scripts/config -e EXPERT -e 64BIT -e SMP -e SCHED_SMT -e SCHED_MC -e X86_X2APIC -e MTRR -e X86_PAT && \
scripts/config -e HIGH_RES_TIMERS -e NO_HZ_IDLE -e HZ_250 -e CC_OPTIMIZE_FOR_PERFORMANCE && \
scripts/config -d MODULES -d SLUB_TINY -d BLK_DEV_INITRD --set-val NR_CPUS 32 && \
scripts/config -e PRINTK -e BUG -e BLOCK -e TTY -e VT -e VT_CONSOLE -e UNIX98_PTYS -e MAGIC_SYSRQ && \
scripts/config -e DEVTMPFS -e DEVTMPFS_MOUNT -e BINFMT_ELF -e BINFMT_SCRIPT -e MULTIUSER && \
scripts/config -e PROC_FS -e PROC_SYSCTL -e SYSFS -e TMPFS -e TMPFS_POSIX_ACL -e TMPFS_XATTR -e SHMEM -e SYSVIPC && \
scripts/config -e FUTEX -e EPOLL -e SIGNALFD -e TIMERFD -e EVENTFD -e AIO -e FILE_LOCKING -e ADVISE_SYSCALLS && \
scripts/config -e POSIX_TIMERS -e INOTIFY_USER -e FHANDLE -e AUTOFS_FS;

# systemd, Steam, namespaces
scripts/config -e CGROUPS -e MEMCG -e CGROUP_SCHED -e FAIR_GROUP_SCHED -e CGROUP_PIDS && \
scripts/config -e NAMESPACES -e UTS_NS -e TIME_NS -e IPC_NS -e USER_NS -e PID_NS -e NET_NS && \
scripts/config -e SECCOMP -e SECCOMP_FILTER -e IA32_EMULATION -e NTSYNC && \
scripts/config -e CRYPTO -e CRYPTO_HMAC -e CRYPTO_SHA256 -e CRYPTO_USER_API_HASH;

# Hardware base
scripts/config -e FW_LOADER -e RTC_CLASS -e RTC_DRV_CMOS -e RTC_HCTOSYS -e RTC_SYSTOHC && \
scripts/config -e ACPI -e ACPI_PROCESSOR -e ACPI_BUTTON -e PCI -e PCI_MSI -e DMI -e DMIID && \
scripts/config -e CPU_FREQ -e X86_INTEL_PSTATE -e X86_AMD_PSTATE -e CPU_IDLE -e INTEL_IDLE && \
scripts/config -e HWMON -e SENSORS_CORETEMP -e SENSORS_K10TEMP;

# Disco: NVMe, SATA, USB
scripts/config -e BLK_DEV_NVME -e ATA -e SATA_AHCI -e SCSI -e BLK_DEV_SD && \
scripts/config -e PARTITION_ADVANCED -e EFI_PARTITION && \
scripts/config -e USB_SUPPORT -e USB -e USB_PCI -e USB_XHCI_HCD -e USB_XHCI_PCI -e USB_EHCI_HCD -e USB_EHCI_PCI && \
scripts/config -e USB_STORAGE -e USB_UAS;

# Sistemas de arquivos
scripts/config -e EXT4_FS -e FAT_FS -e VFAT_FS -e NLS -e NLS_CODEPAGE_437 -e NLS_ASCII -e NLS_UTF8 && \
scripts/config --set-str FAT_DEFAULT_IOCHARSET ascii;

# EFI e vídeo (framebuffer é necessário para o sway subir)
scripts/config -e EFI -e EFI_STUB -e EFIVAR_FS -e FB -e FB_EFI -e FB_DEVICE -e FRAMEBUFFER_CONSOLE && \
scripts/config -e DRM -e DRM_KMS_HELPER -e DRM_FBDEV_EMULATION -e DRM_CLIENT_DEFAULT_FBDEV && \
scripts/config -e DRM_I915;        # AMD: -e DRM_AMDGPU -e DRM_AMD_DC (precisa de EXTRA_FIRMWARE)

# Entrada
scripts/config -e INPUT -e INPUT_EVDEV -e INPUT_KEYBOARD -e KEYBOARD_ATKBD -e INPUT_MOUSE -e MOUSE_PS2 && \
scripts/config -e SERIO -e SERIO_I8042 -e INPUT_MISC -e INPUT_UINPUT && \
scripts/config -e HID_SUPPORT -e HID -e HID_GENERIC -e USB_HID -e HIDRAW;

# Áudio
scripts/config -e SOUND -e SND -e SND_PCI -e SND_HDA_INTEL -e SND_HDA_CODEC_REALTEK -e SND_HDA_CODEC_HDMI -e SND_USB_AUDIO;

# Rede
scripts/config -e NET -e INET -e IPV6 -e UNIX -e PACKET -e NETDEVICES -e NET_CORE -e IP_MULTIPLE_TABLES -e RFKILL && \
scripts/config -e ETHERNET -e NET_VENDOR_REALTEK -e R8169 -e REALTEK_PHY && \
scripts/config -e WIRELESS -e CFG80211 -e MAC80211 -e WLAN -e WLAN_VENDOR_INTEL -e IWLWIFI -e IWLMVM;

make -C /KERNEL/linux-* olddefconfig > /dev/null 2>&1;
sed -i -E \
-e '/^\s*$/d' \
-e 's/^(# ?)?(CONFIG_SWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWAP_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CPU_MITIGATIONS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XENFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWIOTLB_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DYNAMIC_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DYNAMIC_DEBUG_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DVB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DVB_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SPEAKUP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SPEAKUP_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INFINIBAND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INFINIBAND_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_YENTA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_YENTA_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MISDN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MISDN_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PPS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PPS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MODULES)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LOGO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPOOL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ARCH_HIBERNATION_HEADER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PTP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PTP_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CRASH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CRASH_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KEXEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KEXEC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LIVEUPDATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LIVEUPDATE_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT2_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT3)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT3_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ROOT_NFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PNFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PNFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUNRPC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUNRPC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LOCKD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LOCKD_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH5K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH5K_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH6KL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH6KL_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH9K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH9K_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH10K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ATH10K_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_DEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_DEV_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_HW)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_HW_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_FIPS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_FIPS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_ANSI_CPRNG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_ANSI_CPRNG_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_BENCHMARK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_BENCHMARK_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_TEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_TEST_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CRYPTO_STATS_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_STACKPROTECTOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_STACKPROTECTOR_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_STACKPROTECTOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_STACKPROTECTOR_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HW_RANDOM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HW_RANDOM_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SERIAL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SERIAL_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_POWER_RESET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_POWER_RESET_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W1_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MTD_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SPI_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCMA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCMA_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SSB_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_[^= ]+)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SOFT_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CROS_EC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9052_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9055_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9063_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9062_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LENOVO_SE10_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LENOVO_SE30_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MENF21BMC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MENZ069_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WDAT_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WM831X_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WM8350_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XILINX_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZIIRAVE_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RAVE_SP_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MLX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CADENCE_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DW_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TWL4030_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX63XX_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RETU_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ACQUIRE_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADVANTECH_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADVANTECH_EC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ALIM1535_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ALIM7101_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CGBC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EBC_C384_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXAR_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F71808E_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SP5100_TCO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SBC_FITPC2_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EUROTECH_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IB700_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IBMASR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WAFER_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_I6300ESB_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IE6XX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_OC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ITCO_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ITCO_VENDOR_SUPPORT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IT8712F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IT87_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HPWDT_NMI_DECODING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KEMPLD_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SC1200_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PC87413_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NV_TCO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_60XX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SMSC_SCH311X_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SMSC37B787_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TQMX86_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIA_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83627HF_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83877F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83977F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MACHZ_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SBC_EPX_C3_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_MEI_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NI903X_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NIC7018_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SIEMENS_SIMATIC_IPC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEN_A21_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_FS_MBCACHE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NILFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_64BIT_CLUSTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_LZX_XPRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KASAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MSHV_ROOT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AUDIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_A11Y_BRAILLE_CONSOLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISO9660_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JOLIET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZISOFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_UDF_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INPUT_TABLET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INPUT_TOUCHSCREEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AFE4403)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AFE4404)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX30100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX30102)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AM2315)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DHT11)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ENS210)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC100X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC2010)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC3020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_HUMIDITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTU21)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI7005)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI7020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ACPI_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADJD_S311)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADUX1020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3000A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3010)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3320A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9160)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9300)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9306)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9960)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AS73211)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1745)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1750)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1780)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM32181)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3323)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3605)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM36651)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_CROS_EC_LIGHT_PROX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GP2AP002)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GP2AP020A00F)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IQS621_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_ISL29018)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_ISL29028)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL29125)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL76682)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_PROX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JSA1212)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ROHM_BU27034)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RPR0521)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_LM3533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTR390)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTR501)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTRF216A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LV0104CS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX44000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX44009)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NOA1305)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT3001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT4001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT4060)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PA12203001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI1133)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI1145)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_STK3310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TCS3414)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TCS3472)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_TSL2563)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2583)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2591)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2772)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL4531)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_US5182D)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL4000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL4035)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML3235)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6030)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6040)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6070)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6075)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VL6180)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZOPT2201)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ABP060MG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ROHM_BM1390)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_CROS_EC_BARO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DLHL60D)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DPS310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_PRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP03)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ICP10100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL3115)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5637)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SDP500)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_T5403)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP206C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AS3935)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CROS_EC_MKBP_PROXIMITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_D3323AA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HX9023S)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IRSD200)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL29501)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LIDAR_LITE_V2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MB1232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RFD77402)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SRF04)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9324)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9360)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9500)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SRF08)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL3020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VL53L0X_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AW96103)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AS_HAS_NON_CONST_ULEB128)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PAHOLE_HAS_SPLIT_BTF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GDB_SCRIPTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_FRAME_WARN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_STRIP_ASM_SYMS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_READABLE_ASM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HEADERS_INSTALL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECTION_MISMATCH_WARN_ONLY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OBJTOOL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OBJTOOL_WERROR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTUALIZATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_X86_SGX_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERVISOR_GUEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_XXL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_SPINLOCKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMUFD_DRIVER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AMD_IOMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DMAR_TABLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU_SVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU_FLOPPY_WA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_IOMMU_PERF_EVENTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMUFD_DRIVER_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMUFD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IRQ_REMAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEDIA_CEC_RC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEDIA_CEC_SUPPORT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_USB_PULSE8_CEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_USB_RAINSHADOW_CEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_GZIP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_BZIP2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_LZMA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_XZ)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KERNEL_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_GZIP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_BZIP2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_LZMA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_XZ)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KERNEL_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_737)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_775)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_850)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_852)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_855)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_857)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_860)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_861)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_862)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_863)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_864)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_865)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_866)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_869)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_936)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_950)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_932)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_949)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_874)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_1250)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_1251)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_KOI8_R)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_KOI8_U)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_UCS2_UTILS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PD6729)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_I82092)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PCCARD_NONSTATIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RAPIDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DP83640_PHY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DPLL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZL3073X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZL3073X_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZL3073X_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HFI1_DEBUG_SDMA_ORDER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SDMA_VERBOSITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MANA_INFINIBAND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MLX4_INFINIBAND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MLX5_INFINIBAND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RDMA_RXE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RDMA_SIW)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VGEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VKMS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VMWGFX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VMWGFX_MKSSTATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_UDL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_AST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_MGAG200)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_QXL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VIRTIO_GPU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DRM_VIRTIO_GPU_KMS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_EBPF_JIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ARCH_WANT_DEFAULT_BPF_JIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_SYSCALL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_JIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_JIT_ALWAYS_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_JIT_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_UNPRIV_DEFAULT_OFF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_PRELOAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BPF_LSM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VMCORE_INFO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BLK_DEV_INITRD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INITRAMFS_SOURCE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IWLWIFI)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_WLAN)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_WLAN_VENDOR_INTEL)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_RFKILL)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FB)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FB_EFI)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FB_DEVICE)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_DRM_FBDEV_EMULATION)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_DRM_FBDEV_OVERALLOC)(=.*| is not set)?$/\2=100/' \
-e 's/^(# ?)?(CONFIG_DRM_CLIENT_LOG)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_DRM_CLIENT_DEFAULT_FBDEV)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FRAMEBUFFER_CONSOLE)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_NAMESPACES)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_UTS_NS)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_TIME_NS)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_TIME_NS_VDSO)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_IPC_NS)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_USER_NS)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_PID_NS)(=.*| is not set)?$/\2=y/' \
-e 's/^(# ?)?(CONFIG_NET_NS)(=.*| is not set)?$/\2=y/' \
/KERNEL/linux-*/.config && \
make -C /KERNEL/linux-* -j$(nproc) && \
cp /KERNEL/linux-*/arch/x86/boot/bzImage /boot/vmlinuz-bux && \
cd /;


mkdir -p /FIRMWARE && \
git clone --filter=blob:none --no-checkout --depth=1 https://gitlab.com/kernel-firmware/linux-firmware.git /FIRMWARE && \
git -C /FIRMWARE sparse-checkout set --no-cone '/*' '!/ath3k-1.fw' '!/bnx2x' '!/cxgb3' '!/cxgb4' '!/wil6210.*' '!/ath6k' '!/ti-connectivity' '!/dvb-*' '!/tigon' '!/dpaa2' '!/nxp' '!/dabusb' '!/3com' '!/go7007' '!/keyspan' '!/keyspan_pda' '!/mellanox' '!/qcom' '!/netronome' '!/brcm' '!/qed' '!/mrvl' '!/ath10k' && \
git -C /FIRMWARE checkout && \
mkdir -p /usr/lib/firmware && \
mv /FIRMWARE/* /usr/lib/firmware;



reboot;
