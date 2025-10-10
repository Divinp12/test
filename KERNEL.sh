#!/bin/bash

sudo pacman -Sy --noconfirm --quiet bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz wget && \
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.15.2.tar.xz && \
sudo tar -xvf linux-6.*.tar.xz && \
cd linux-6.15.2 && \
sudo make clean -j$(nproc) && \
sudo make mrproper -j$(nproc) && \
sudo make defconfig -j$(nproc);

#DESATIVAR SWAP
sudo sed -i 's/^.*CONFIG_SWAP.*$/CONFIG_SWAP=n/' .config;

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
#CONFIG_BT=m
#CONFIG_BT_BREDR=y
#CONFIG_BT_RFCOMM=m
#CONFIG_BT_RFCOMM_TTY=y
#CONFIG_BT_BNEP=m
#CONFIG_BT_BNEP_MC_FILTER=y
#CONFIG_BT_BNEP_PROTO_FILTER=y
#CONFIG_BT_HIDP=m
#CONFIG_BT_LE=y
#CONFIG_BT_LE_L2CAP_ECRED=y
#CONFIG_BT_6LOWPAN=m
#CONFIG_BT_LEDS=y
#CONFIG_BT_MSFTEXT=y
#CONFIG_BT_AOSPEXT=y
#CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
#CONFIG_BT_INTEL=m
#CONFIG_BT_BCM=m
#CONFIG_BT_RTL=m
#CONFIG_BT_QCA=m
#CONFIG_BT_MTK=m
#CONFIG_BT_HCIBTUSB=m
#CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
#CONFIG_BT_HCIBTUSB_POLL_SYNC=y
#CONFIG_BT_HCIBTUSB_BCM=y
#CONFIG_BT_HCIBTUSB_MTK=y
#CONFIG_BT_HCIBTUSB_RTL=y
#CONFIG_BT_HCIBTSDIO=m
#CONFIG_BT_HCIUART=m
#CONFIG_BT_HCIUART_SERDEV=y
#CONFIG_BT_HCIUART_H4=y
#CONFIG_BT_HCIUART_NOKIA=m
#CONFIG_BT_HCIUART_BCSP=y
#CONFIG_BT_HCIUART_ATH3K=y
#CONFIG_BT_HCIUART_LL=y
#CONFIG_BT_HCIUART_3WIRE=y
#CONFIG_BT_HCIUART_INTEL=y
#CONFIG_BT_HCIUART_BCM=y
#CONFIG_BT_HCIUART_RTL=y
#CONFIG_BT_HCIUART_QCA=y
#CONFIG_BT_HCIUART_AG6XX=y
#CONFIG_BT_HCIUART_MRVL=y
#CONFIG_BT_HCIUART_AML=y
#CONFIG_BT_HCIBCM203X=m
#CONFIG_BT_HCIBCM4377=m
#CONFIG_BT_HCIBPA10X=m
#CONFIG_BT_HCIBFUSB=m
#CONFIG_BT_HCIDTL1=m
#CONFIG_BT_HCIBT3C=m
#CONFIG_BT_HCIBLUECARD=m
#CONFIG_BT_HCIVHCI=m
#CONFIG_BT_MRVL=m
#CONFIG_BT_MRVL_SDIO=m
#CONFIG_BT_ATH3K=m
#CONFIG_BT_MTKSDIO=m
#CONFIG_BT_MTKUART=m
#CONFIG_BT_HCIRSI=m
#CONFIG_BT_VIRTIO=m
#CONFIG_BT_NXPUART=m
#CONFIG_BT_INTEL_PCIE=m

sudo make -j$(nproc) && \
sudo make modules_install -j$(nproc) && \
sudo make install -j$(nproc);
