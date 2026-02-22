#!/bin/bash

clear && \
cd /home/bux/ && \
sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
git clone https://gitlab.archlinux.org/archlinux/packaging/packages/linux.git && \
#-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \

sudo sed -i -E \
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
-e 's/^(# ?)?(CONFIG_INPUT_TABLET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_ACECAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_AIPTEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_HANWANG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_KBTAB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_PEGASUS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_SERIAL_WACOM4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INPUT_TOUCHSCREEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_88PM860X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ADS7846)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7877)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ADC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ATMEL_MXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ATMEL_MXT_T37)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AUO_PIXCIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_BU21013)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_BU21029)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CHIPONE_ICN8505)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CY8CTMA140)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CY8CTMG110)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP5)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DA9034)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DA9052)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DYNAPRO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HAMPSHIRE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EETI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EXC3000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_FUJITSU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HIDEEP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HYCON_HY46XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ILI210X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ILITEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_S6SY761)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GUNZE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EKTF2127)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ELAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ELO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WACOM_W8001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WACOM_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MAX11801)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MMS114)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MELFAS_MIP4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MSG2638)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IMAGIS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_INEXIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PENMOUNT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EDT_FT5X06)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHRIGHT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHWIN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PIXCIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WDT87XX_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM831X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM97XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9705)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9712)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9713)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_COMPOSITE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MC13783)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_EGALAX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_PANJIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_3M)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ITM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ETURBO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GUNZE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_DMC_TSC10)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_IRTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_IDEALTEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GOTOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_JASTEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ELO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_E2I)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ZYTRONIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ETT_TC45USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_NEXIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_EASYTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHIT213)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC_SERIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC200X_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2004)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2005)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2007)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2007_IIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PCAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_RM_TS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SILEAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SIS_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ST1232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_STMFTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SUR40)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SURFACE3_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SX8654)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TPS6507X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZET6223)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZFORCE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_COLIBRI_VF50)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ROHM_BU21023)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IQS5XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IQS7211)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZINITIX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)(=.*| is not set)?$/\2=n/' \
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
-e 's/^(# ?)?(CONFIG_DEBUG_KERNEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_INFO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DYNAMIC_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DYNAMIC_DEBUG_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_RING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_TASK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_IOTLB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_MENU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_NET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_SCSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_VSOCK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_VDPA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_CROSS_ENDIAN_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_ANCHOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LIB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LIB_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MENU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_ADMIN_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_VDPA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PMEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_INPUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MMIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_DMA_SHARED_BUFFER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC_PTP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC_CLASS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_PFNCACHE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQCHIP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQ_ROUTING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING_TSO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_MMIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_ASYNC_PF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_MSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_READONLY_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_VFIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_COMPAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQ_BYPASS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_NO_POLL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_XFER_TO_GUEST_WORK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_PM_NOTIFIER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_HARDWARE_ENABLING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_MMU_NOTIFIER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_MMU_LOCKLESS_AGING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_PRIVATE_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_PRIVATE_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTUALIZATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_X86)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_X86_SGX_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_AMD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_AMD_SEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_IOAPIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_SMM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_HYPERV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_EXTERNAL_WRITE_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERVISOR_GUEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_XXL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_SPINLOCKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_TRF7970A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MEI_PHY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_SIM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PORT100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_VIRTUAL_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_FDP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_FDP_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544_MEI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533_USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN532_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD_MEI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST21NFCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST21NFCA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_NXP_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_NXP_NCI_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN5)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN5_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN82_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST95HF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_IOVA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_API)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMUFD_DRIVER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_SUPPORT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_IO_PGTABLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_DEBUGFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_DEFAULT_DMA_STRICT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_DEFAULT_DMA_LAZY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_DEFAULT_PASSTHROUGH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_DMA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_SVA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IOMMU_IOPF)(=.*| is not set)?$/\2=n/' \
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
-e 's/^(# ?)?(CONFIG_HYPERV_IOMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_IOMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_NOTIFIER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_PIN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEDIA_CEC_RC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_PIN_ERROR_INJ)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEDIA_CEC_SUPPORT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_CH7322)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_NXP_TDA9950)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_CROS_EC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_SECO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CEC_SECO_RC)(=.*| is not set)?$/\2=n/' \
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
-e 's/^(# ?)?(CONFIG_RD_GZIP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_BZIP2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_LZMA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_XZ)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RD_LZ4)(=.*| is not set)?$/\2=n/' \
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
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_8)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_1250)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_CODEPAGE_1251)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_3)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_5)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_6)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_7)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_9)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_13)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_14)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_ISO8859_15)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_KOI8_R)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_KOI8_U)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_ROMAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_CELTIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_CENTEURO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_CROATIAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_CYRILLIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_GAELIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_GREEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_ICELAND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_INUIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_ROMANIAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_MAC_TURKISH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NLS_UCS2_UTILS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_ALI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_AMD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_ARTOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_ATIIXP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_ATP867X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_CMD64X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_CYPRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_EFAR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_HPT366)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_HPT37X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PATA_HPT3X2N)(=.*| is not set)?$/\2=n/' \

-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(testandoollll)(=.*| is not set)?$/\2=n/' \
/home/bux/linux/config.x86_64 && \
makepkg -si --noconfirm --skippgpcheck --skipchecksums --skipinteg && \
sudo mkinitcpio -P && \
sudo grub-mkconfig -o /boot/grub/grub.cfg;

CONFIG_PATA_HPT3X3=m
CONFIG_PATA_HPT3X3_DMA=y
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
CONFIG_PATA_RZ1000=m
CONFIG_PATA_PARPORT=m

#
# Parallel IDE protocol modules
#
CONFIG_PATA_PARPORT_ATEN=m
CONFIG_PATA_PARPORT_BPCK=m
CONFIG_PATA_PARPORT_BPCK6=m
CONFIG_PATA_PARPORT_COMM=m
CONFIG_PATA_PARPORT_DSTR=m
CONFIG_PATA_PARPORT_FIT2=m
CONFIG_PATA_PARPORT_FIT3=m
CONFIG_PATA_PARPORT_EPAT=m
CONFIG_PATA_PARPORT_EPATC8=y
CONFIG_PATA_PARPORT_EPIA=m
CONFIG_PATA_PARPORT_FRIQ=m
CONFIG_PATA_PARPORT_FRPW=m
CONFIG_PATA_PARPORT_KBIC=m
CONFIG_PATA_PARPORT_KTTI=m
CONFIG_PATA_PARPORT_ON20=m
CONFIG_PATA_PARPORT_ON26=m

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_PATA_LEGACY=m

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set


#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m
CONFIG_PPS_GENERATOR=m
# CONFIG_PPS_GENERATOR_DUMMY is not set
CONFIG_PPS_GENERATOR_TIO=m

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m
CONFIG_PTP_1588_CLOCK_OPTIONAL=m
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_INES=m
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PTP_1588_CLOCK_VMCLOCK=m
CONFIG_PTP_1588_CLOCK_IDT82P33=m
CONFIG_PTP_1588_CLOCK_IDTCM=m
CONFIG_PTP_1588_CLOCK_FC3W=m
CONFIG_PTP_1588_CLOCK_MOCK=m
CONFIG_PTP_1588_CLOCK_VMW=m
CONFIG_PTP_1588_CLOCK_OCP=m
CONFIG_PTP_DFL_TOD=m
CONFIG_PTP_NETC_V4_TIMER=m
# end of PTP clock support


# CONFIG_DEBUG_PREEMPT
# CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
# CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CLOSURES is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
