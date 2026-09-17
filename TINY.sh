#!/bin/bash
clear;

cd /home/bux/ && \
sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz && \
git clone https://gitlab.archlinux.org/archlinux/packaging/packages/linux.git && \

cd /home/bux/linux && \
makepkg -si --noconfirm --skippgpcheck --skipchecksums --skipinteg && \
sudo mkinitcpio -P &&
