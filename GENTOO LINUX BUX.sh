#!/bin/bash
set -e
trap 'echo "FALHOU no comando: $BASH_COMMAND"' ERR
clear;

echo "formatando 1 disco valido";
wipefs -a /dev/sda > /dev/null 2>&1 && \
parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart ESP fat32 1MiB 100MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 100MiB 30000MiB && \
parted -s /dev/sda mkpart primary ext4 30000MiB 100% && \
partprobe && \
mkfs.fat -F32 /dev/sda1 > /dev/null 2>&1 && \
mkfs.ext4 -F /dev/sda2 > /dev/null 2>&1 && \
mkfs.ext4 -F /dev/sda3 > /dev/null 2>&1 && \
mount /dev/sda2 /mnt/gentoo && \
mkdir /mnt/gentoo/boot && \
mkdir /mnt/gentoo/boot/EFI && \
mount /dev/sda1 /mnt/gentoo/boot/EFI && \
mkdir /mnt/gentoo/home && \
mount /dev/sda3 /mnt/gentoo/home && \
wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20260322T154603Z/stage3-amd64-nomultilib-openrc-20260322T154603Z.tar.xz > /dev/null 2>&1 && \
tar xvpf /mnt/gentoo/stage3-*.tar.xz -C /mnt/gentoo --xattrs-include='*.*' --numeric-owner > /dev/null 2>&1 && \
rm -rf /mnt/gentoo/stage3-*.tar.xz > /dev/null 2>&1 && \
mkdir -p /mnt/gentoo/etc && \
echo "UUID=$(blkid -s UUID -o value /dev/sda1) /boot/EFI vfat rw,relatime,noatime 0 2
UUID=$(blkid -s UUID -o value /dev/sda2) / ext4 rw,relatime,noatime 0 1
UUID=$(blkid -s UUID -o value /dev/sda3) /home ext4 rw,relatime,noatime 0 2" > /mnt/gentoo/etc/fstab && \
mount -a -v && \
echo "";


echo "sobscrevendo arquivo make.conf para instalacao do gcc";
echo 'COMMON_FLAGS="-O2"
CFLAGS="-O2"
CXXFLAGS="-O2"
FCFLAGS="-O2"
FFLAGS="-O2"
MAKEOPTS="-j\$(nproc)"
USE=""
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf;


echo "adicionando pasta package.mask no diretorio /mnt/gentoo/etc/portage";
mkdir -p /mnt/gentoo/etc/portage/package.mask;


echo "adicionando bloqueio de instalação e atualização de pacotes não usados";
echo "app-shells/fish
app-shells/zsh
app-shells/zsh-completions
kde-plasma/plasma-meta
kde-plasma/kde-apps-meta
kde-plasma/plasma-desktop
gnome-base/gdm
sys-apps/systemd" > /mnt/gentoo/etc/portage/package.mask/pacotes;


echo "adicionando pasta package.provided no diretorio /mnt/gentoo/etc/portage";
mkdir -p /mnt/gentoo/etc/portage/package.provided;


echo "adicionando ignoração de verificação de pacotes não usados";
echo "app-shells/fish
app-shells/zsh
app-shells/zsh-completions
kde-plasma/plasma-meta
kde-plasma/kde-apps-meta
kde-plasma/plasma-desktop
gnome-base/gdm
sys-apps/systemd" > /mnt/gentoo/etc/portage/package.provided/pacotes;


echo "adicionando pasta package.license no diretorio /mnt/gentoo/etc/portage";
mkdir -p /mnt/gentoo/etc/portage/package.license;


echo "adicionando licença de pacotes especificos";
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" > /mnt/gentoo/etc/portage/package.license/pacotes;


echo "adicionando pasta package.accept_keywords no diretorio /etc/portage";
mkdir -p /mnt/gentoo/etc/portage/package.accept_keywords;


echo "habilitando versões especificas de pacotes"
echo "=sys-kernel/gentoo-sources-6.19.8
=sys-devel/gcc-15.2.1_p20260214" > /mnt/gentoo/etc/portage/package.accept_keywords/pacotes;


echo "adicionando pasta package.use no diretorio /mnt/gentoo/etc/portage";
mkdir -p /mnt/gentoo/etc/portage/package.use;


echo "criando configuração do pacote";
echo "dev-build/make -doc -nls -test
dev-build/cmake -doc -gui -ncurses -test
sys-devel/binutils -nls -doc -zstd
sys-apps/coreutils -nls -selinux -test
sys-apps/util-linux -nls -selinux -audit -systemd -test
app-shells/bash -net -examples -nls -plugins
media-libs/mesa opengl vulkan lavapipe -X -debug -zstd -virgl -vmware -zink
gui-wm/sway -swaybar -wallpapers
dev-libs/wayland -doc
app-misc/fastfetch -X -gnome -xfce
media-sound/pulseaudio-daemon -X -doc -systemd
net-misc/networkmanager -gtk-doc -modemmanager -bluetooth -systemd
sys-boot/grub -fonts -themes -doc -efiemu -libzfs -nls -sdl -secureboot -truetype
media-libs/freetype harfbuzz -debug -doc -X
net-misc/wget -libproxy -debug -nls
net-misc/curl -debug
www-client/google-chrome pt-BR -selinux -af -am -ar -bg -bn -ca -cs -da -de -el -en-GB -es -es-419 -et -fa -fi -fil -fr -gu -he -hi -hr -hu -id -it -ja -kn -ko -lt -lv -ml -mr -ms -nb -nl -pl -pt-PT -ro -ru -sk -sl -sr -sv -sw -ta -te -th -tr -uk -ur -vi -zh-CN -zh-TW
" > /mnt/gentoo/etc/portage/package.use/pacotes;


echo "adicionando fuso horario brasileiro";
cp /mnt/gentoo/usr/share/zoneinfo/America/Sao_Paulo /mnt/gentoo/etc/localtime;


echo "adicionando identificador de fuso horario brasileiro";
echo "America/Sao_Paulo" > /mnt/gentoo/etc/timezone;


echo "adicionando idioma e caracteres brasileiro";
echo "pt_BR.UTF-8 UTF-8" > /mnt/gentoo/etc/locale.gen;


echo "adicionando suporte ipv6";
echo "127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 bux.localdomain bux" > /mnt/gentoo/etc/hosts;


echo "copiando arquivo resolv.conf e colando em /etc";
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/;


echo "montando pasta proc";
mount --types proc /proc /mnt/gentoo/proc/;


echo "montando pasta sys";
mount --rbind /sys /mnt/gentoo/sys;


echo "montando pasta sys novamente";
mount --make-rslave /mnt/gentoo/sys;


echo "montando pasta dev";
mount --rbind /dev /mnt/gentoo/dev;


echo "montando pasta dev novamente";
mount --make-rslave /mnt/gentoo/dev;


echo "montando pasta run";
mount --bind /run /mnt/gentoo/run;


echo "montando pasta run novamente";
mount --make-slave /mnt/gentoo/run;


echo "criando pasta repos.conf em /mnt/gentoo/etc/portage";
mkdir --parents /mnt/gentoo/etc/portage/repos.conf;


echo "copiando arquivo repos.conf e colando em /mnt/gentoo/etc/portage/repos.conf";
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf;


echo "entrando no ambiente chroot";
chroot /mnt/gentoo /bin/bash -c '

echo "aplicando mudanças de idiomas e caracteres brasileiro";
source /etc/profile && locale-gen > /dev/null 2>&1;


echo "sincronizando arvore de ebuilds do gentoo via web";
emerge-webrsync --quiet > /dev/null 2>&1;


echo "selecionando perfil do portage";
eselect profile set 1 > /dev/null 2>&1;


echo "sincronizando repositorios do portage";
emerge --sync --quiet > /dev/null 2>&1;


echo "instalando gcc";
emerge --quiet =sys-devel/gcc-15.2.1_p20260214;


echo "instalando glibc";
emerge --quiet sys-libs/glibc;


echo "sobscrevendo arquivo make.conf para sistema e instalação dos pacotes do sistema";
echo "COMMON_FLAGS=\"-O2 -march=native -mtune=native\"
CFLAGS=\"-O2 -march=native -mtune=native\"
CXXFLAGS=\"-O2 -march=native -mtune=native\"
FCFLAGS=\"-O2 -march=native -mtune=native\"
FFLAGS=\"-O2 -march=native -mtune=native\"
RUSTFLAGS=\"\${RUSTFLAGS} -C target-cpu=native\"
MAKEOPTS=\"-j\$(nproc)\"
USE=\"wayland pulseaudio dbus openrc -nls -X -aqua -bluetooth -doc -gtk-doc -kde -plasma -systemd -selinux -audit -test -debug -pie\"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS=\"http://gentoo.c3sl.ufpr.br/\"" > /mnt/gentoo/etc/portage/make.conf;


echo "instalando pacotes importantes";
emerge --quiet \
sys-devel/binutils \
sys-apps/coreutils \
app-shells/bash \
sys-libs/ncurses \
sys-libs/readline \
sys-apps/file \
sys-kernel/linux-firmware \
sys-firmware/sof-firmware \
=sys-kernel/gentoo-sources-6.19.8 \
media-libs/mesa \
dev-libs/wayland \
gui-wm/sway \
gui-apps/wofi \
app-misc/fastfetch \
media-sound/pulseaudio-daemon \
net-misc/networkmanager \
net-misc/dhcpcd \
sys-boot/grub \
sys-boot/efibootmgr \
@system;


echo "atualizando variáveis de ambiente globais";
source /etc/profile && env-update;


echo "limpando kernel customizavel";
make clean -j$(nproc) -C /usr/src/linux*/;


echo "limpando profundamente kernel customizavel";
make mrproper -j$(nproc) -C /usr/src/linux*/;


echo "adicionando arquivo de configuração (.config)";
make defconfig -j$(nproc) -C /usr/src/linux*/;


echo "configurando arquivo de configuração (.config)";
sed -i -E \
/mnt/gentoo/usr/src/linux*/.config;


echo "compilando kernel customizavel";
make all -j$(nproc) -C /usr/src/linux*/;


echo "instalando modulos do kernel customizavel";
make modules_install -j$(nproc) -C /usr/src/linux*/;


echo "instalando kernel customizavel";
make install -j$(nproc) -C /usr/src/linux*/;


echo "adicionando nome bux ao usuario root";
echo "hostname=\"bux\"" > /mnt/gentoo/etc/conf.d/hostname;


echo "adicionando senha bux ao usuario root";
echo -e "bux\nbux" | passwd root;


echo "adicionando usuario normal com nome bux";
useradd -m -g users -G wheel bux;


echo "adicionando senha bux ao usuario normal";
echo -e "bux\nbux" | passwd bux;


echo "adicionando autostartx do kde plasma";
echo "exec sway > /dev/null 2>&1" > /mnt/gentoo/home/bux/.bash_profile;


echo "adicionando diretorio de configuração do sway";
mkdir -p /mnt/gentoo/home/bux/.config/sway;


echo "adicionando arquivo de configuração do sway";
echo "set \$mod Mod4
default_border pixel 1
default_floating_border none
input * { pointer_accel 0 }
output * bg #000000 solid_color
output * { compositor none }
bindsym \$mod+z exec foot
bindsym \$mod+x kill
bindsym \$mod+v exec wofi --show drun --no-dmenu
bindsym \$mod+c reload
bindsym \$mod+b fullscreen toggle
bindsym --locked XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
bindsym --locked XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle
bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+
include /etc/sway/config.d/*" > /mnt/gentoo/home/bux/.config/sway/config;


echo "adicionando diretorio de configuração extra do sway";
mkdir -p /mnt/gentoo/etc/sway;


echo "adicionando arquivo de configuração extra do sway";
echo "set \$mod Mod4
default_border pixel 1
default_floating_border none
input * { pointer_accel 0 }
output * bg #000000 solid_color
output * { compositor none }
bindsym \$mod+z exec foot
bindsym \$mod+x kill
bindsym \$mod+v exec wofi --show drun --no-dmenu
bindsym \$mod+c reload
bindsym \$mod+b fullscreen toggle
bindsym --locked XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
bindsym --locked XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle
bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+
include /etc/sway/config.d/*" > /mnt/gentoo/etc/sway/config;


echo "adicionando suporte DHCP na inicializacao";
rc-update add dhcpcd default;


echo "adicionando suporte NetworkManager na inicializacao";
rc-update add NetworkManager default;


echo "sobscrevendo arquivo grub";
echo "GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\"bux\"
GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"
GRUB_CMDLINE_LINUX=\"\"
GRUB_PRELOAD_MODULES=\"part_gpt part_msdos\"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true" > /mnt/gentoo/etc/default/grub;


echo "configurando grub";
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=bux --recheck > /dev/null 2>&1;


echo "adicionando grub na inicialização";
grub-mkconfig -o /boot/grub/grub.cfg > /dev/null 2>&1;
