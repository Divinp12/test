#!/bin/bash
clear;
cd /tmp && \
sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
wget https://cdn.kernel.org/pub/linux/kernel/v7.x/linux-7.2.6.tar.xz && \
make tinyconfig && \
make -j$(nproc);

#sudo mkinitcpio -P
