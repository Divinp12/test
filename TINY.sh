#!/bin/bash
clear;
sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
wget -P /tmp https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.6.tar.xz && \
tar xvpf /tmp/linux-*.tar.xz -C /tmp --xattrs-include='*.*' --numeric-owner && \
sudo rm -rf /tmp/linux-*.tar.xz && \
make tinyconfig && \
make -j$(nproc);
sudo mkinitcpio -k /boot/vmlinuz-bux -g /boot/initramfs-bux.img

#sudo mkinitcpio -P
