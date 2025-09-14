#!/bin/bash

dd if=/dev/zero of=/dev/sda bs=64M && \
parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart ESP fat32 1MiB 900MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 900MiB 30000MiB && \
parted -s /dev/sda mkpart primary ext4 30000MiB 100% && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 -F /dev/sda2 && \
mkfs.ext4 -F /dev/sda3 && \
mount /dev/sda2 /mnt/gentoo && \
mkdir /mnt/gentoo/boot && \
mount /dev/sda1 /mnt/gentoo/boot && \
mkdir /mnt/gentoo/home && \
mount /dev/sda3 /mnt/gentoo/home && \
wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20250907T165007Z/stage3-amd64-openrc-20250907T165007Z.tar.xz && \
tar xvpf /mnt/gentoo/stage3-amd64-openrc-20250907T165007Z.tar.xz -C /mnt/gentoo --xattrs --numeric-owner && \
echo 'USE="bindist"
MAKEOPTS"-j2"
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' >> /mnt/gentoo/etc/portage/make.conf && \
cp -L /etc/resolv.conf /mnt/gentoo/etc/ && \
mount -t proc /proc /mnt/gentoo/proc/ && \
mount --rbind /sys /mnt/gentoo/sys && \
mount --rbind /dev /mnt/gentoo/dev && \
chroot /mnt/gentoo /bin/bash -c "source /etc/profile && \
emerge-webrsync && \
emerge --sync && \
eselect profile set 7 && \
cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
echo 'Sao_Paulo' > /etc/timezone && \
echo 'pt_BR.UTF-8 UTF-8' > /etc/locale.gen && \
locale-gen && \
env-update && \
source /etc/profile && \
emerge sys-kernel/gentoo-sources && \
echo '/dev/sda1 /boot vfat defaults 0 1' > /etc/fstab && \
make clean -j$(nproc) -C /usr/src/linux*/ && \
make mrproper -j$(nproc) -C /usr/src/linux*/ && \
make defconfig -j$(nproc) -C /usr/src/linux*/ && \
"
