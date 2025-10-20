#!/bin/bash

sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz wget && \
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.54.tar.xz && \
sudo tar -xvpf linux-6.12.54.tar.xz --xattrs-include='*.*' --numeric-owner && \
cd linux-6.12.54 && \
sudo make clean -j64 && \
sudo make mrproper -j64 && \
sudo make defconfig -j64;

#DESATIVAR SWAP
sudo sed -i 's/^.*CONFIG_SWAP.*$/#/' .config;

#DESATIVAR ZSWAP
sudo sed -i 's/^.*CONFIG_ZSWAP.*$/CONFIG_ZSWAP=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_DEFAULT_ON.*$/CONFIG_ZSWAP_DEFAULT_ON=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_SHRINKER_DEFAULT_ON.*$/CONFIG_ZSWAP_SHRINKER_DEFAULT_ON=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD.*$/CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=n/' .config;
sudo sed -i 's/^.*CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC.*$/CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=n/' .config;

#DESATIVAR ZRAM
sudo sed -i 's/^.*CONFIG_ZRAM.*$/CONFIG_ZRAM=n/' .config;

#DESATIVAR MITIGATIONS
sudo sed -i 's/^.*CONFIG_CPU_MITIGATIONS.*$/CONFIG_CPU_MITIGATIONS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.*$/CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_RETPOLINE.*$/CONFIG_MITIGATION_RETPOLINE=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_RETHUNK.*$/CONFIG_MITIGATION_RETHUNK=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_UNRET_ENTRY.*$/CONFIG_MITIGATION_UNRET_ENTRY=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_CALL_DEPTH_TRACKING.*$/CONFIG_MITIGATION_CALL_DEPTH_TRACKING=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_IBPB_ENTRY.*$/CONFIG_MITIGATION_IBPB_ENTRY=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_IBRS_ENTRY.*$/CONFIG_MITIGATION_IBRS_ENTRY=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SRSO.*$/CONFIG_MITIGATION_SRSO=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SLS.*$/CONFIG_MITIGATION_SLS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_GDS.*$/CONFIG_MITIGATION_GDS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_RFDS.*$/CONFIG_MITIGATION_RFDS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_BHI.*$/CONFIG_MITIGATION_SPECTRE_BHI=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_MDS.*$/CONFIG_MITIGATION_MDS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_TAA.*$/CONFIG_MITIGATION_TAA=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_MMIO_STALE_DATA.*$/CONFIG_MITIGATION_MMIO_STALE_DATA=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_L1TF.*$/CONFIG_MITIGATION_L1TF=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_RETBLEED.*$/CONFIG_MITIGATION_RETBLEED=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_V1.*$/CONFIG_MITIGATION_SPECTRE_V1=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_V2.*$/CONFIG_MITIGATION_SPECTRE_V2=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SRBDS.*$/CONFIG_MITIGATION_SRBDS=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_SSB.*$/CONFIG_MITIGATION_SSB=n/' .config;
sudo sed -i 's/^.*CONFIG_MITIGATION_ITS.*$/CONFIG_MITIGATION_ITS=n/' .config;

#DESATIVAR WATCHDOG
sudo sed -i 's/^.*CONFIG_WATCHDOG.*$/CONFIG_WATCHDOG=n/' .config;
sudo sed -i 's/^.*CONFIG_WATCHDOG_CORE.*$/CONFIG_WATCHDOG_CORE=n/' .config;
sudo sed -i 's/^.*CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED.*$/CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=n/' .config;

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_CROS_EC_WATCHDOG=m
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_LENOVO_SE10_WDT=m
CONFIG_LENOVO_SE30_WDT=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_MLX_WDT=m
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ADVANTECH_EC_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_CGBC_WDT=m
CONFIG_EBC_C384_WDT=m
CONFIG_EXAR_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=m
CONFIG_INTEL_OC_WATCHDOG=m
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_SIEMENS_SIMATIC_IPC_WDT=m
CONFIG_MEN_A21_WDT=m
CONFIG_XEN_WDT=m

#DESATIVAR SUSPENSAO
sudo sed -i 's/^.*CONFIG_SUSPEND.*$/CONFIG_SUSPEND=n/' .config;
sudo sed -i 's/^.*CONFIG_SUSPEND_FREEZER.*$/CONFIG_SUSPEND_FREEZER=n/' .config;

#DESATIVAR HIBERNACAO
sudo sed -i 's/^.*CONFIG_HIBERNATE_CALLBACKS.*$/CONFIG_HIBERNATE_CALLBACKS=n/' .config;
sudo sed -i 's/^.*CONFIG_HIBERNATION.*$/CONFIG_HIBERNATION=n/' .config;
sudo sed -i 's/^.*CONFIG_HIBERNATION_SNAPSHOT_DEV.*$/CONFIG_HIBERNATION_SNAPSHOT_DEV=n/' .config;
sudo sed -i 's/^.*CONFIG_HIBERNATION_COMP_LZO.*$/CONFIG_HIBERNATION_COMP_LZO=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS EXT2
sudo sed -i 's/^.*CONFIG_EXT2_FS.*$/CONFIG_EXT2_FS=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS EXT3
sudo sed -i 's/^.*CONFIG_EXT3_FS.*$/CONFIG_EXT3_FS=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS JFS
sudo sed -i 's/^.*CONFIG_JFS_FS.*$/CONFIG_JFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_JFS_POSIX_ACL.*$/CONFIG_JFS_POSIX_ACL=n/' .config;
sudo sed -i 's/^.*CONFIG_JFS_SECURITY.*$/CONFIG_JFS_SECURITY=n/' .config;
sudo sed -i 's/^.*CONFIG_JFS_DEBUG.*$/CONFIG_JFS_DEBUG=n/' .config;
sudo sed -i 's/^.*CONFIG_JFS_STATISTICS.*$/CONFIG_JFS_STATISTICS=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS XFS
sudo sed -i 's/^.*CONFIG_XFS_FS.*$/CONFIG_XFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_SUPPORT_V4.*$/CONFIG_XFS_SUPPORT_V4=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_SUPPORT_ASCII_CI.*$/CONFIG_XFS_SUPPORT_ASCII_CI=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_QUOTA.*$/CONFIG_XFS_QUOTA=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_POSIX_ACL.*$/CONFIG_XFS_POSIX_ACL=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_RT.*$/CONFIG_XFS_RT=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_DRAIN_INTENTS.*$/CONFIG_XFS_DRAIN_INTENTS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_LIVE_HOOKS.*$/CONFIG_XFS_LIVE_HOOKS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_MEMORY_BUFS.*$/CONFIG_XFS_MEMORY_BUFS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_BTREE_IN_MEM.*$/CONFIG_XFS_BTREE_IN_MEM=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_ONLINE_SCRUB.*$/CONFIG_XFS_ONLINE_SCRUB=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_ONLINE_SCRUB_STATS.*$/CONFIG_XFS_ONLINE_SCRUB_STATS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_ONLINE_REPAIR.*$/CONFIG_XFS_ONLINE_REPAIR=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_WARN.*$/CONFIG_XFS_WARN=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_DEBUG.*$/CONFIG_XFS_DEBUG=n/' .config;

sudo sed -i 's/^.*CONFIG_GFS2_FS.*$/CONFIG_GFS2_FS=n/' .config;

sudo sed -i 's/^.*CONFIG_BTRFS_FS.*$/CONFIG_BTRFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_FS_POSIX_ACL.*$/CONFIG_BTRFS_FS_POSIX_ACL=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_FS_RUN_SANITY_TESTS.*$/CONFIG_BTRFS_FS_RUN_SANITY_TESTS=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_DEBUG.*$/CONFIG_BTRFS_DEBUG=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_ASSERT.*$/CONFIG_BTRFS_ASSERT=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_EXPERIMENTAL.*$/CONFIG_BTRFS_EXPERIMENTAL=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_FS_REF_VERIFY.*$/CONFIG_BTRFS_FS_REF_VERIFY=n/' .config;

sudo sed -i 's/^.*CONFIG_NILFS2_FS.*$/CONFIG_NILFS2_FS=n/' .config;

sudo sed -i 's/^.*CONFIG_F2FS_FS.*$/CONFIG_F2FS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_STAT_FS.*$/CONFIG_F2FS_STAT_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_XATTR.*$/CONFIG_F2FS_FS_XATTR=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_POSIX_ACL.*$/CONFIG_F2FS_FS_POSIX_ACL=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_SECURITY.*$/CONFIG_F2FS_FS_SECURITY=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_CHECK_FS.*$/CONFIG_F2FS_CHECK_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FAULT_INJECTION.*$/CONFIG_F2FS_FAULT_INJECTION=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_COMPRESSION.*$/CONFIG_F2FS_FS_COMPRESSION=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_LZO.*$/CONFIG_F2FS_FS_LZO=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_LZORLE.*$/CONFIG_F2FS_FS_LZORLE=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_LZ4.*$/CONFIG_F2FS_FS_LZ4=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_LZ4HC.*$/CONFIG_F2FS_FS_LZ4HC=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS_ZSTD.*$/CONFIG_F2FS_FS_ZSTD=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_IOSTAT.*$/CONFIG_F2FS_IOSTAT=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_UNFAIR_RWSEM.*$/CONFIG_F2FS_UNFAIR_RWSEM=n/' .config;

sudo sed -i 's/^.*CONFIG_BCACHEFS_FS.*$/CONFIG_BCACHEFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_QUOTA.*$/CONFIG_BCACHEFS_QUOTA=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_ERASURE_CODING.*$/CONFIG_BCACHEFS_ERASURE_CODING=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_POSIX_ACL.*$/CONFIG_BCACHEFS_POSIX_ACL=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_DEBUG.*$/CONFIG_BCACHEFS_DEBUG=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_TESTS.*$/CONFIG_BCACHEFS_TESTS=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_LOCK_TIME_STATS.*$/CONFIG_BCACHEFS_LOCK_TIME_STATS=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_NO_LATENCY_ACCT.*$/CONFIG_BCACHEFS_NO_LATENCY_ACCT=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN.*$/CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_PATH_TRACEPOINTS.*$/CONFIG_BCACHEFS_PATH_TRACEPOINTS=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_TRANS_KMALLOC_TRACE.*$/CONFIG_BCACHEFS_TRANS_KMALLOC_TRACE=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS.*$/CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS=n/' .config;

sudo sed -i 's/^.*CONFIG_NTFS_FS.*$/CONFIG_NTFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_NTFS3_FS.*$/CONFIG_NTFS3_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_NTFS3_64BIT_CLUSTER.*$/CONFIG_NTFS3_64BIT_CLUSTER=n/' .config;
sudo sed -i 's/^.*CONFIG_NTFS3_LZX_XPRESS.*$/CONFIG_NTFS3_LZX_XPRESS=n/' .config;
sudo sed -i 's/^.*CONFIG_NTFS3_FS_POSIX_ACL.*$/CONFIG_NTFS3_FS_POSIX_ACL=n/' .config;

#DESATIVAR RANDOMIZAÇÃO DE MEMORIA
sudo sed -i 's/^.*CONFIG_RANDOMIZE_BASE.*$/CONFIG_RANDOMIZE_BASE=n/' .config;
sudo sed -i 's/^.*CONFIG_RANDOMIZE_MEMORY.*$/CONFIG_RANDOMIZE_MEMORY=n/' .config;

#DESATIVAR DEBUG
sudo sed -i 's/^.*CONFIG_DEBUG_KERNEL.*$/CONFIG_DEBUG_KERNEL=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_MISC.*$/CONFIG_DEBUG_MISC=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_LIST.*$/CONFIG_DEBUG_LIST=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_PLIST.*$/CONFIG_DEBUG_PLIST=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_SG.*$/CONFIG_DEBUG_SG=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_NOTIFIERS.*$/CONFIG_DEBUG_NOTIFIERS=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_MAPLE_TREE.*$/CONFIG_DEBUG_MAPLE_TREE=n/' .config;

#DESATIVAR KASAN
sudo sed -i 's/^.*CONFIG_KASAN.*$/CONFIG_KASAN=n/' .config;

#DESATIVAR HYPERV
sudo sed -i 's/^.*CONFIG_HYPERV.*$/CONFIG_HYPERV=n/' .config;
sudo sed -i 's/^.*CONFIG_HYPERVISOR_GUEST.*$/CONFIG_HYPERVISOR_GUEST=n/' .config;
sudo sed -i 's/^.*CONFIG_HYPERV_VTL_MODE.*$/CONFIG_HYPERV_VTL_MODE=n/' .config;
sudo sed -i 's/^.*CONFIG_HYPERV_TIMER.*$/CONFIG_HYPERV_TIMER=n/' .config;
sudo sed -i 's/^.*CONFIG_HYPERV_UTILS.*$/CONFIG_HYPERV_UTILS=n/' .config;
sudo sed -i 's/^.*CONFIG_HYPERV_BALLOON.*$/CONFIG_HYPERV_BALLOON=n/' .config;
sudo sed -i 's/^.*CONFIG_MSHV_ROOT.*$/CONFIG_MSHV_ROOT=n/' .config;

#DESATIVAR AUDIT
sudo sed -i 's/^.*CONFIG_AUDIT.*$/CONFIG_AUDIT=n/' .config;

#DESATIVAR SELINUX
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX.*$/CONFIG_SECURITY_SELINUX=n/' .config;
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX_DEBUG.*$/CONFIG_SECURITY_SELINUX_DEBUG=n/' .config;
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX_BOOTPARAM.*$/CONFIG_SECURITY_SELINUX_BOOTPARAM=n/' .config;
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX_DEVELOP.*$/CONFIG_SECURITY_SELINUX_DEVELOP=n/' .config;
sudo sed -i 's/^.*CONFIG_SECURITY_SELINUX_AVC_STATS.*$/CONFIG_SECURITY_SELINUX_AVC_STATS=n/' .config;

#DESATIVAR XEN
sudo sed -i 's/^.*CONFIG_XEN.*$/CONFIG_XEN=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PV.*$/CONFIG_XEN_PV=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_512GB.*$/CONFIG_XEN_512GB=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PV_SMP.*$/CONFIG_XEN_PV_SMP=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PV_DOM0.*$/CONFIG_XEN_PV_DOM0=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVHVM.*$/CONFIG_XEN_PVHVM=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVHVM_SMP.*$/CONFIG_XEN_PVHVM_SMP=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVHVM_GUEST.*$/CONFIG_XEN_PVHVM_GUEST=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_SAVE_RESTORE.*$/CONFIG_XEN_SAVE_RESTORE=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_DEBUG_FS.*$/CONFIG_XEN_DEBUG_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVH.*$/CONFIG_XEN_PVH=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_DOM0.*$/CONFIG_XEN_DOM0=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PV_MSR_SAFE.*$/CONFIG_XEN_PV_MSR_SAFE=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_BALLOON.*$/CONFIG_XEN_BALLOON=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_BALLOON_MEMORY_HOTPLUG.*$/CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_SCRUB_PAGES_DEFAULT.*$/CONFIG_XEN_SCRUB_PAGES_DEFAULT=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_DEV_EVTCHN.*$/CONFIG_XEN_DEV_EVTCHN=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_BACKEND.*$/CONFIG_XEN_BACKEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XENFS.*$/CONFIG_XENFS=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_COMPAT_XENFS.*$/CONFIG_XEN_COMPAT_XENFS=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_SYS_HYPERVISOR.*$/CONFIG_XEN_SYS_HYPERVISOR=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_XENBUS_FRONTEND.*$/CONFIG_XEN_XENBUS_FRONTEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_GNTDEV.*$/CONFIG_XEN_GNTDEV=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_GNTDEV_DMABUF.*$/CONFIG_XEN_GNTDEV_DMABUF=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_GRANT_DEV_ALLOC.*$/CONFIG_XEN_GRANT_DEV_ALLOC=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_GRANT_DMA_ALLOC.*$/CONFIG_XEN_GRANT_DMA_ALLOC=n/' .config;
sudo sed -i 's/^.*CONFIG_SWIOTLB_XEN.*$/CONFIG_SWIOTLB_XEN=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PCI_STUB.*$/CONFIG_XEN_PCI_STUB=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PCIDEV_BACKEND.*$/CONFIG_XEN_PCIDEV_BACKEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVCALLS_FRONTEND.*$/CONFIG_XEN_PVCALLS_FRONTEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PVCALLS_BACKEND.*$/CONFIG_XEN_PVCALLS_BACKEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_SCSI_BACKEND.*$/CONFIG_XEN_SCSI_BACKEND=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PRIVCMD.*$/CONFIG_XEN_PRIVCMD=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_PRIVCMD_EVENTFD.*$/CONFIG_XEN_PRIVCMD_EVENTFD=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_ACPI_PROCESSOR.*$/CONFIG_XEN_ACPI_PROCESSOR=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_MCE_LOG.*$/CONFIG_XEN_MCE_LOG=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_HAVE_PVMMU.*$/CONFIG_XEN_HAVE_PVMMU=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_EFI.*$/CONFIG_XEN_EFI=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_AUTO_XLATE.*$/CONFIG_XEN_AUTO_XLATE=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_ACPI.*$/CONFIG_XEN_ACPI=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_SYMS.*$/CONFIG_XEN_SYMS=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_HAVE_VPMU.*$/CONFIG_XEN_HAVE_VPMU=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_FRONT_PGDIR_SHBUF.*$/CONFIG_XEN_FRONT_PGDIR_SHBUF=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_UNPOPULATED_ALLOC.*$/CONFIG_XEN_UNPOPULATED_ALLOC=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_GRANT_DMA_OPS.*$/CONFIG_XEN_GRANT_DMA_OPS=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_VIRTIO.*$/CONFIG_XEN_VIRTIO=n/' .config;
sudo sed -i 's/^.*CONFIG_XEN_VIRTIO_FORCE_GRANT.*$/CONFIG_XEN_VIRTIO_FORCE_GRANT=n/' .config;

#DESATIVAR DRIVERS DE LEDS
sudo sed -i 's/^.*CONFIG_LEDS_APU.*$/CONFIG_LEDS_APU=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_AW200XX.*$/CONFIG_LEDS_AW200XX=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_LM3530.*$/CONFIG_LEDS_LM3530=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_LM3532.*$/CONFIG_LEDS_LM3532=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_LM3642.*$/CONFIG_LEDS_LM3642=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_PCA9532.*$/CONFIG_LEDS_PCA9532=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_LP3944.*$/CONFIG_LEDS_LP3944=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_PCA955X.*$/CONFIG_LEDS_PCA955X=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_PCA963X.*$/CONFIG_LEDS_PCA963X=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_PCA995X.*$/CONFIG_LEDS_PCA995X=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_BD2606MVV.*$/CONFIG_LEDS_BD2606MVV=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_BD2802.*$/CONFIG_LEDS_BD2802=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_INTEL_SS4200.*$/CONFIG_LEDS_INTEL_SS4200=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_TCA6507.*$/CONFIG_LEDS_TCA6507=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_TLC591XX.*$/CONFIG_LEDS_TLC591XX=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_LM355x.*$/CONFIG_LEDS_LM355x=n/' .config;
sudo sed -i 's/^.*CONFIG_LEDS_IS31FL319X.*$/CONFIG_LEDS_IS31FL319X=n/' .config;

# DESATIVAR SUPORTE BLUETOOTH
sudo sed -i 's/^.*CONFIG_BT.*$/CONFIG_BT=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_BREDR.*$/CONFIG_BT_BREDR=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_RFCOMM.*$/CONFIG_BT_RFCOMM=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_RFCOMM_TTY.*$/CONFIG_BT_RFCOMM_TTY=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_BNEP.*$/CONFIG_BT_BNEP=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_BNEP_MC_FILTER.*$/CONFIG_BT_BNEP_MC_FILTER=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_BNEP_PROTO_FILTER.*$/CONFIG_BT_BNEP_PROTO_FILTER=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HIDP.*$/CONFIG_BT_HIDP=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_LE.*$/CONFIG_BT_LE=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_LE_L2CAP_ECRED.*$/CONFIG_BT_LE_L2CAP_ECRED=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_6LOWPAN.*$/CONFIG_BT_6LOWPAN=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_LEDS.*$/CONFIG_BT_LEDS=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MSFTEXT.*$/CONFIG_BT_MSFTEXT=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_AOSPEXT.*$/CONFIG_BT_AOSPEXT=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_DEBUGFS.*$/CONFIG_BT_DEBUGFS=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_SELFTEST.*$/CONFIG_BT_SELFTEST=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_INTEL.*$/CONFIG_BT_INTEL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_BCM.*$/CONFIG_BT_BCM=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_RTL.*$/CONFIG_BT_RTL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_QCA.*$/CONFIG_BT_QCA=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MTK.*$/CONFIG_BT_MTK=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB.*$/CONFIG_BT_HCIBTUSB=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB_AUTOSUSPEND.*$/CONFIG_BT_HCIBTUSB_AUTOSUSPEND=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB_POLL_SYNC.*$/CONFIG_BT_HCIBTUSB_POLL_SYNC=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB_BCM.*$/CONFIG_BT_HCIBTUSB_BCM=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB_MTK.*$/CONFIG_BT_HCIBTUSB_MTK=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTUSB_RTL.*$/CONFIG_BT_HCIBTUSB_RTL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBTSDIO.*$/CONFIG_BT_HCIBTSDIO=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART.*$/CONFIG_BT_HCIUART=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_SERDEV.*$/CONFIG_BT_HCIUART_SERDEV=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_H4.*$/CONFIG_BT_HCIUART_H4=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_NOKIA.*$/CONFIG_BT_HCIUART_NOKIA=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_BCSP.*$/CONFIG_BT_HCIUART_BCSP=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_ATH3K.*$/CONFIG_BT_HCIUART_ATH3K=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_LL.*$/CONFIG_BT_HCIUART_LL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_3WIRE.*$/CONFIG_BT_HCIUART_3WIRE=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_INTEL.*$/CONFIG_BT_HCIUART_INTEL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_BCM.*$/CONFIG_BT_HCIUART_BCM=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_RTL.*$/CONFIG_BT_HCIUART_RTL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_QCA.*$/CONFIG_BT_HCIUART_QCA=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_AG6XX.*$/CONFIG_BT_HCIUART_AG6XX=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_MRVL.*$/CONFIG_BT_HCIUART_MRVL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIUART_AML.*$/CONFIG_BT_HCIUART_AML=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBCM203X.*$/CONFIG_BT_HCIBCM203X=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBCM4377.*$/CONFIG_BT_HCIBCM4377=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBPA10X.*$/CONFIG_BT_HCIBPA10X=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBFUSB.*$/CONFIG_BT_HCIBFUSB=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIDTL1.*$/CONFIG_BT_HCIDTL1=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBT3C.*$/CONFIG_BT_HCIBT3C=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIBLUECARD.*$/CONFIG_BT_HCIBLUECARD=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIVHCI.*$/CONFIG_BT_HCIVHCI=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MRVL.*$/CONFIG_BT_MRVL=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MRVL_SDIO.*$/CONFIG_BT_MRVL_SDIO=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_ATH3K.*$/CONFIG_BT_ATH3K=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MTKSDIO.*$/CONFIG_BT_MTKSDIO=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_MTKUART.*$/CONFIG_BT_MTKUART=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_HCIRSI.*$/CONFIG_BT_HCIRSI=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_VIRTIO.*$/CONFIG_BT_VIRTIO=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_NXPUART.*$/CONFIG_BT_NXPUART=n/' .config;
sudo sed -i 's/^.*CONFIG_BT_INTEL_PCIE.*$/CONFIG_BT_INTEL_PCIE=n/' .config;

# SISTEMA DE ARQUIVOS CD-ROM E DVD
sudo sed -i 's/^.*CONFIG_ISO9660_FS.*$/CONFIG_ISO9660_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_JOLIET.*$/CONFIG_JOLIET=n/' .config;
sudo sed -i 's/^.*CONFIG_ZISOFS.*$/CONFIG_ZISOFS=n/' .config;
sudo sed -i 's/^.*CONFIG_UDF_FS.*$/CONFIG_UDF_FS=n/' .config;

sudo make -j64 && \
sudo make modules_install -j64 && \
sudo make install -j64 && \
sudo mv arch/x86/boot/bzImage /boot/vmlinuz-6.12.54 && \
sudo mkinitcpio -k $(make -s kernelversion) -g /boot/initramfs-6.12.54.img && \
sudo mkinitcpio -P && \
sudo grub-mkconfig -o /boot/grub/grub.cfg
