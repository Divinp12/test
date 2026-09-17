#!/bin/bash
clear;
cd /tmp && \
sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
git clone https://github.com/torvalds/linux && \
make tinyconfig && \
make -j$(nproc);

#sudo mkinitcpio -P
