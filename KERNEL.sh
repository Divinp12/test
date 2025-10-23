#!/bin/bash

sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz wget && \
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.54.tar.xz && \
sudo tar -xvpf linux-6.12.54.tar.xz --xattrs-include='*.*' --numeric-owner && \
cd linux-6.12.54 && \
sudo make clean -j64 && \
sudo make mrproper -j64 && \
sudo make defconfig -j64;
#-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \

sed -i -E \
-e 's/^(# ?)?(CONFIG_ZPOOL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_SHRINKER_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC_STAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZORLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_WRITEBACK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_TRACK_ENTRY_ACTIME)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_MEMORY_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_MULTI_COMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CPU_MITIGATIONS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETPOLINE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETHUNK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_UNRET_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_IBPB_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_IBRS_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SRSO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SLS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_GDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RFDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_BHI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_MDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_TAA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_MMIO_STALE_DATA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_L1TF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETBLEED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_V1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_V2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SRBDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_ITS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_TSA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_VMSCAPE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND_FREEZER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ARCH_HIBERNATION_HEADER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATE_CALLBACKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_SNAPSHOT_DEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_COMP_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_COMP_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_NOWAYOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_SYSFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)(=.*| is not set)?$/\2=n/' \
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
-e 's/^(# ?)?(CONFIG_XEN_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT3_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_FS_MBCACHE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_SECURITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_STATISTICS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_SUPPORT_V4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_SUPPORT_ASCII_CI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_QUOTA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_RT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_DRAIN_INTENTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_LIVE_HOOKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_MEMORY_BUFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_BTREE_IN_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_SCRUB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_SCRUB_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_REPAIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_WARN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2_FS_LOCKING_DLM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_O2CB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_USERSPACE_CLUSTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_DEBUG_MASKLOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_RUN_SANITY_TESTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_ASSERT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_EXPERIMENTAL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_REF_VERIFY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NILFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_STAT_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_XATTR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_SECURITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_CHECK_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FAULT_INJECTION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_COMPRESSION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZORLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_IOSTAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_UNFAIR_RWSEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_QUOTA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_ERASURE_CODING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_TESTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_LOCK_TIME_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_NO_LATENCY_ACCT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_PATH_TRACEPOINTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_TRANS_KMALLOC_TRACE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_64BIT_CLUSTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_LZX_XPRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE_BASE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE_MEMORY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KASAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_VTL_MODE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_TIMER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_UTILS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MSHV_ROOT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AUDIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_BOOTPARAM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_DEVELOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_AVC_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_512GB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_SMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_DOM0)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM_SMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM_GUEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SAVE_RESTORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DOM0)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_MSR_SAFE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BALLOON_MEMORY_HOTPLUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SCRUB_PAGES_DEFAULT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DEV_EVTCHN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XENFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_COMPAT_XENFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SYS_HYPERVISOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_XENBUS_FRONTEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GNTDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GNTDEV_DMABUF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DEV_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DMA_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWIOTLB_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PCI_STUB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PCIDEV_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVCALLS_FRONTEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVCALLS_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SCSI_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PRIVCMD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PRIVCMD_EVENTFD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_ACPI_PROCESSOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_MCE_LOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_HAVE_PVMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_EFI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_AUTO_XLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_ACPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SYMS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_HAVE_VPMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_FRONT_PGDIR_SHBUF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_UNPOPULATED_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DMA_OPS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_VIRTIO_FORCE_GRANT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_88PM860X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_APU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_AW200XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_CHT_WCOVE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_CROS_EC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3530)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3532)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3642)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6323)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA9532)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA9532_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP3944)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP3952)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP50XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP8788)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA955X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA955X_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA963X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA995X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_QNAP_MCU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_WM831X_STATUS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_WM8350)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DA903X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DA9052)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DAC124S085)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PWM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_REGULATOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BD2606MVV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BD2802)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_INTEL_SS4200)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LT3593)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_ADP5520)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MC13783)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TCA6507)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TLC591XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MAX77705)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MAX8997)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM355x)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MENF21BMC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_IS31FL319X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_UPBOARD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BLINKM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BLINKM_MULTICOLOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MLXREG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MLXCPLD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_USER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_NIC78BX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SPI_BYTE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TI_LMU_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM36274)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TPS6105X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_AS3645A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3601X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6370_FLASH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_RT8515)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SGM3140)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_KTD202X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PWM_MULTICOLOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6370_RGB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGERS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TIMER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_ONESHOT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_DISK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_MTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_HEARTBEAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_BACKLIGHT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_CPU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_ACTIVITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TRANSIENT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_CAMERA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_PANIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_NETDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_PATTERN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TTY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_INPUT_EVENTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_A11Y_BRAILLE_CONSOLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BREDR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RFCOMM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RFCOMM_TTY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP_MC_FILTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP_PROTO_FILTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HIDP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LE_L2CAP_ECRED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_6LOWPAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LEDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MSFTEXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_AOSPEXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_DEBUGFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_SELFTEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_QCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_AUTOSUSPEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_POLL_SYNC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_MTK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTSDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_SERDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_H4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_NOKIA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_BCSP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_ATH3K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_LL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_3WIRE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_QCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_AG6XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_AML)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBCM203X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBCM4377)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBPA10X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBFUSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIDTL1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBT3C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBLUECARD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIVHCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MRVL_SDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_ATH3K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTKSDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTKUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIRSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_NXPUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_INTEL_PCIE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISO9660_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JOLIET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZISOFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_UDF_FS)(=.*| is not set)?$/\2=n/' \
.config

CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP5=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_ILITEK=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=m
CONFIG_TOUCHSCREEN_IMAGIS=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_IQS7211=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_TOUCHSCREEN_HIMAX_HX83112B=m


# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_ENS210=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HDC3020=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

# Light sensors
#
#CONFIG_ACPI_ALS=m
#CONFIG_ADJD_S311=m
#CONFIG_ADUX1020=m
#CONFIG_AL3000A=m
#CONFIG_AL3010=m
#CONFIG_AL3320A=m
#CONFIG_APDS9160=m
#CONFIG_APDS9300=m
#CONFIG_APDS9306=m
#CONFIG_APDS9960=m
#CONFIG_AS73211=m
#CONFIG_BH1745=m
#CONFIG_BH1750=m
#CONFIG_BH1780=m
#CONFIG_CM32181=m
#CONFIG_CM3232=m
#CONFIG_CM3323=m
#CONFIG_CM3605=m
#CONFIG_CM36651=m
#CONFIG_IIO_CROS_EC_LIGHT_PROX=m
#CONFIG_GP2AP002=m
#CONFIG_GP2AP020A00F=m
#CONFIG_IQS621_ALS=m
#CONFIG_SENSORS_ISL29018=m
#CONFIG_SENSORS_ISL29028=m
#CONFIG_ISL29125=m
#CONFIG_ISL76682=m
#CONFIG_HID_SENSOR_ALS=m
#CONFIG_HID_SENSOR_PROX=m
#CONFIG_JSA1212=m
#CONFIG_ROHM_BU27034=m
#CONFIG_RPR0521=m
#CONFIG_SENSORS_LM3533=m
#CONFIG_LTR390=m
#CONFIG_LTR501=m
#CONFIG_LTRF216A=m
#CONFIG_LV0104CS=m
#CONFIG_MAX44000=m
#CONFIG_MAX44009=m
#CONFIG_NOA1305=m
#CONFIG_OPT3001=m
#CONFIG_OPT4001=m
#CONFIG_OPT4060=m
#CONFIG_PA12203001=m
#CONFIG_SI1133=m
#CONFIG_SI1145=m
#CONFIG_STK3310=m
#CONFIG_ST_UVIS25=m
#CONFIG_ST_UVIS25_I2C=m
#CONFIG_ST_UVIS25_SPI=m
#CONFIG_TCS3414=m
#CONFIG_TCS3472=m
#CONFIG_SENSORS_TSL2563=m
#CONFIG_TSL2583=m
#CONFIG_TSL2591=m
#CONFIG_TSL2772=m
#CONFIG_TSL4531=m
#CONFIG_US5182D=m
#CONFIG_VCNL4000=m
#CONFIG_VCNL4035=m
#CONFIG_VEML3235=m
#CONFIG_VEML6030=m
#CONFIG_VEML6040=m
#CONFIG_VEML6070=m
#CONFIG_VEML6075=m
#CONFIG_VL6180=m
#CONFIG_ZOPT2201=m
# end of Light sensors

# Pressure sensors
#
#CONFIG_ABP060MG=m
#CONFIG_ROHM_BM1390=m
#CONFIG_BMP280=m
#CONFIG_BMP280_I2C=m
#CONFIG_BMP280_SPI=m
#CONFIG_IIO_CROS_EC_BARO=m
#CONFIG_DLHL60D=m
#CONFIG_DPS310=m
#CONFIG_HID_SENSOR_PRESS=m
#CONFIG_HP03=m
#CONFIG_HSC030PA=m
#CONFIG_HSC030PA_I2C=m
#CONFIG_HSC030PA_SPI=m
#CONFIG_ICP10100=m
#CONFIG_MPL115=m
#CONFIG_MPL115_I2C=m
#CONFIG_MPL115_SPI=m
#CONFIG_MPL3115=m
#CONFIG_MPRLS0025PA=m
#CONFIG_MPRLS0025PA_I2C=m
#CONFIG_MPRLS0025PA_SPI=m
#CONFIG_MS5611=m
#CONFIG_MS5611_I2C=m
#CONFIG_MS5611_SPI=m
#CONFIG_MS5637=m
#CONFIG_SDP500=m
#CONFIG_IIO_ST_PRESS=m
#CONFIG_IIO_ST_PRESS_I2C=m
#CONFIG_IIO_ST_PRESS_SPI=m
#CONFIG_T5403=m
#CONFIG_HP206C=m
#CONFIG_ZPA2326=m
#CONFIG_ZPA2326_I2C=m
#CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

# Lightning sensors
#
#CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
#CONFIG_CROS_EC_MKBP_PROXIMITY=m
#CONFIG_D3323AA=m
#CONFIG_HX9023S=m
#CONFIG_IRSD200=m
#CONFIG_ISL29501=m
#CONFIG_LIDAR_LITE_V2=m
#CONFIG_MB1232=m
#CONFIG_PING=m
#CONFIG_RFD77402=m
#CONFIG_SRF04=m
#CONFIG_SX_COMMON=m
#CONFIG_SX9310=m
#CONFIG_SX9324=m
#CONFIG_SX9360=m
#CONFIG_SX9500=m
#CONFIG_SRF08=m
#CONFIG_VCNL3020=m
#CONFIG_VL53L0X_I2C=m
#CONFIG_AW96103=m
# end of Proximity and distance sensors

sudo make -j64 && \
sudo make modules_install -j64 && \
sudo make install -j64 && \
sudo mv arch/x86/boot/bzImage /boot/vmlinuz-6.12.54 && \
sudo mkinitcpio -k $(make -s kernelversion) -g /boot/initramfs-6.12.54.img && \
sudo mkinitcpio -P && \
sudo grub-mkconfig -o /boot/grub/grub.cfg
