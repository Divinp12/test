#!/bin/bash

wipefs -a /dev/sda && \
parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart ESP fat32 1MiB 500MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 500MiB 30000MiB && \
parted -s /dev/sda mkpart primary ext4 30000MiB 100% && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 -F /dev/sda2 && \
mkfs.ext4 -F /dev/sda3 && \
mount /dev/sda2 /mnt/gentoo && \
mkdir /mnt/gentoo/boot && \
mkdir /mnt/gentoo/boot/EFI && \
mount /dev/sda1 /mnt/gentoo/boot/EFI && \
mkdir /mnt/gentoo/home && \
mount /dev/sda3 /mnt/gentoo/home


if wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20250907T165007Z/stage3-amd64-openrc-20250907T165007Z.tar.xz; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if tar xvpf /mnt/gentoo/stage3-amd64-openrc-20250907T165007Z.tar.xz -C /mnt/gentoo --xattrs-include='*.*' --numeric-owner; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo 'COMMON_FLAGS="-O2 -pipe -march=native"
CFLAGS="-O2 -pipe -march=native"
CXXFLAGS="-O2 -pipe -march=native"
FCFLAGS="-O2 -pipe -march=native"
FFLAGS="-O2 -pipe -march=native"
USE=""
MAKEOPTS="-j2"
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if cp --dereference /etc/resolv.conf /mnt/gentoo/etc/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --types proc /proc /mnt/gentoo/proc/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --rbind /sys /mnt/gentoo/sys; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --make-rslave /mnt/gentoo/sys; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --rbind /dev /mnt/gentoo/dev; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --make-rslave /mnt/gentoo/dev; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --bind /run /mnt/gentoo/run; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if mount --make-slave /mnt/gentoo/run; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if emerge-webrsync; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if eselect profile set 4; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if emerge --sync; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


emerge --verbose --update --deep --changed-use @world && \

cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \

echo 'Sao_Paulo' > /etc/timezone && \

echo 'pt_BR.UTF-8 UTF-8' > /etc/locale.gen && \

locale-gen && \

env-update && \

emerge sys-kernel/gentoo-sources && \

make clean -j16 -C /usr/src/linux*/ && \

make mrproper -j16 -C /usr/src/linux*/ && \

make defconfig -j16 -C /usr/src/linux*/ && \

sed -i 's/^.*CONFIG_SWAP.*$/CONFIG_SWAP=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_ZSWAP.*$/CONFIG_ZSWAP=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_ZRAM.*$/CONFIG_ZRAM=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_CPU_MITIGATIONS.*$/CONFIG_CPU_MITIGATIONS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.*$/CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_RETPOLINE.*$/CONFIG_MITIGATION_RETPOLINE=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_RETHUNK.*$/CONFIG_MITIGATION_RETHUNK=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_UNRET_ENTRY.*$/CONFIG_MITIGATION_UNRET_ENTRY=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_CALL_DEPTH_TRACKING.*$/CONFIG_MITIGATION_CALL_DEPTH_TRACKING=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_IBPB_ENTRY.*$/CONFIG_MITIGATION_IBPB_ENTRY=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_IBRS_ENTRY.*$/CONFIG_MITIGATION_IBRS_ENTRY=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SRSO.*$/CONFIG_MITIGATION_SRSO=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SLS.*$/CONFIG_MITIGATION_SLS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_GDS.*$/CONFIG_MITIGATION_GDS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_RFDS.*$/CONFIG_MITIGATION_RFDS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_BHI.*$/CONFIG_MITIGATION_SPECTRE_BHI=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_MDS.*$/CONFIG_MITIGATION_MDS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_TAA.*$/CONFIG_MITIGATION_TAA=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_MMIO_STALE_DATA.*$/CONFIG_MITIGATION_MMIO_STALE_DATA=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_L1TF.*$/CONFIG_MITIGATION_L1TF=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_RETBLEED.*$/CONFIG_MITIGATION_RETBLEED=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_V1.*$/CONFIG_MITIGATION_SPECTRE_V1=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SPECTRE_V2.*$/CONFIG_MITIGATION_SPECTRE_V2=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SRBDS.*$/CONFIG_MITIGATION_SRBDS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_SSB.*$/CONFIG_MITIGATION_SSB=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_MITIGATION_ITS.*$/CONFIG_MITIGATION_ITS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_WATCHDOG.*$/CONFIG_WATCHDOG=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_WATCHDOG_CORE.*$/CONFIG_WATCHDOG_CORE=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED.*$/CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_SUSPEND.*$/CONFIG_SUSPEND=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_SUSPEND_FREEZER.*$/CONFIG_SUSPEND_FREEZER=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_HIBERNATE_CALLBACKS.*$/CONFIG_HIBERNATE_CALLBACKS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_HIBERNATION.*$/CONFIG_HIBERNATION=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_HIBERNATION_SNAPSHOT_DEV.*$/CONFIG_HIBERNATION_SNAPSHOT_DEV=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_HIBERNATION_COMP_LZO.*$/CONFIG_HIBERNATION_COMP_LZO=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_EXT2_FS.*$/CONFIG_EXT2_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_EXT3_FS.*$/CONFIG_EXT3_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_JFS_FS.*$/CONFIG_JFS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_XFS_FS.*$/CONFIG_XFS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_GFS2_FS.*$/CONFIG_GFS2_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_BTRFS_FS.*$/CONFIG_BTRFS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_NILFS2_FS.*$/CONFIG_NILFS2_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_F2FS_FS.*$/CONFIG_F2FS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_BCACHEFS_FS.*$/CONFIG_BCACHEFS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_NTFS_FS.*$/CONFIG_NTFS_FS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_RANDOMIZE_BASE.*$/CONFIG_RANDOMIZE_BASE=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_RANDOMIZE_MEMORY.*$/CONFIG_RANDOMIZE_MEMORY=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_KERNEL.*$/CONFIG_DEBUG_KERNEL=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_MISC.*$/CONFIG_DEBUG_MISC=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_LIST.*$/CONFIG_DEBUG_LIST=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_PLIST.*$/CONFIG_DEBUG_PLIST=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_SG.*$/CONFIG_DEBUG_SG=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_NOTIFIERS.*$/CONFIG_DEBUG_NOTIFIERS=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_DEBUG_MAPLE_TREE.*$/CONFIG_DEBUG_MAPLE_TREE=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_KASAN.*$/CONFIG_KASAN=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_HYPERV.*$/CONFIG_HYPERV=n/' /usr/src/linux*/.config;
sed -i 's/^.*CONFIG_AUDIT.*$/CONFIG_AUDIT=n/' /usr/src/linux*/.config;

make -j16 -C /usr/src/linux*/ && \

make modules_install -j16 -C /usr/src/linux*/ && \

make install -j16 -C /usr/src/linux*/ && \

echo '/dev/sda1 /boot vfat defaults 0 1
/dev/sda2 / ext4 defaults, noatime 0 1
/dev/sda3 /home ext4 defaults,noatime 0 2' >> /etc/fstab && \

echo 'hostname=\"bux\"' > /etc/conf.d/hostname && \

echo -e 'bux\nbux' | passwd root && \

useradd -m -g users -G wheel bux && \

echo -e 'bux\nbux' | passwd bux && \

echo '127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 bux.localdomain bux' > /etc/hosts && \

emerge dhcpcd && \

rc-update add dhcpcd default'
