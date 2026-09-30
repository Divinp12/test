#!/bin/bash
clear && \
sudo rm -rf /tmp/linux-* /tmp/linux-*.tar.xz && \
sudo pacman -Sy --needed --noconfirm wget bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
wget -P /tmp https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.6.tar.xz && \
tar xvpf /tmp/linux-*.tar.xz -C /tmp --xattrs-include='*.*' --numeric-owner && \
sudo rm -rf /tmp/linux-*.tar.xz && \
make -C /tmp/linux-* tinyconfig && \
/tmp/linux-*/scripts/config \
  --enable 64BIT \
  --enable ACPI \
  --enable EFI \
  --enable EFI_STUB \
  --enable CMDLINE_BOOL \
  --enable BINFMT_SCRIPT \
  --enable PROC_FS \
  --enable SYSFS \
  --enable DEVTMPFS \
  --enable EXT4_FS \
  --enable VFAT_FS \
  --enable NLS_CODEPAGE_437 \
  --enable NLS_ISO8859_1 \
  --enable UNIX \
  --enable PACKET \
  --enable FUTEX \
  --enable PRINTK \
  --disable MODULES \
  --set-str CMDLINE 'root=/dev/sda2 rootwait rw console=ttyS0,115200 init=/bin/sh' && \
make -C /tmp/linux-* olddefconfig && \
make -C /tmp/linux-* -j$(nproc) && \
sudo mv /tmp/linux-*/arch/x86/boot/bzImage /boot/EFI && \
sudo mv /boot/EFI/bzImage /boot/EFI/vmlinuz-bux && \
sudo mkinitcpio -k /boot/EFI/vmlinuz-bux -g /boot/EFI/initramfs-bux.img
