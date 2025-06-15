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

#DESATIVAR FORMATO DE ARQUIVOS
sudo sed -i 's/^.*CONFIG_EXT2_FS.*$/CONFIG_EXT2_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_EXT3_FS.*$/CONFIG_EXT3_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_JFS_FS.*$/CONFIG_JFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_XFS_FS.*$/CONFIG_XFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_GFS2_FS.*$/CONFIG_GFS2_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_BTRFS_FS.*$/CONFIG_BTRFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_NILFS2_FS.*$/CONFIG_NILFS2_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_F2FS_FS.*$/CONFIG_F2FS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_BCACHEFS_FS.*$/CONFIG_BCACHEFS_FS=n/' .config;
sudo sed -i 's/^.*CONFIG_NTFS_FS.*$/CONFIG_NTFS_FS=n/' .config;

#DESATIVAR RANDOMIZAÇÃO DE MEMORIA
sudo sed -i 's/^.*CONFIG_RANDOMIZE_BASE.*$/CONFIG_RANDOMIZE_BASE=n/' .config;
sudo sed -i 's/^.*CONFIG_RANDOMIZE_MEMORY.*$/CONFIG_RANDOMIZE_MEMORY=n/' .config;

#DESATIVAR DEBUG
sudo sed -i 's/^.*CONFIG_DEBUG_KERNEL.*$/CONFIG_DEBUG_KERNEL=n/' .config;
sudo sed -i 's/^.*CONFIG_DEBUG_MISC.*$/CONFIG_DEBUG_MISC=n/' .config;

#DESATIVAR AUDIT
sudo sed -i 's/^.*CONFIG_AUDIT.*$/CONFIG_AUDIT=n/' .config;

sudo make -j$(nproc) && \
sudo make modules_install -j$(nproc) && \
sudo make install -j$(nproc);
