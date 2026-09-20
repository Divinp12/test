#!/bin/bash
clear;
sudo pacman -Sy --needed --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
wget -P /tmp https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.6.tar.xz && \
tar xvpf /tmp/linux-*.tar.xz -C /tmp --xattrs-include='*.*' --numeric-owner && \
sudo rm -rf /tmp/linux-*.tar.xz && \
make tinyconfig && \
make -C /tmp/linux-* -j$(nproc) && \
sudo mv /tmp/linux-*/arch/x86/boot/bzImage /boot/EFI && \
sudo mv /boot/EFI/bzImage /boot/EFI/vmlinuz-bux && \
sudo mkinitcpio -k /boot/EFI/vmlinuz-bux -g /boot/EFI/initramfs-bux.img
