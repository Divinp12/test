#!/bin/bash

clear;

echo "formatando 1 disco valido";
wipefs -a /dev/sda > /dev/null 2>&1 && \
parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart ESP fat32 1MiB 500MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 500MiB 30000MiB && \
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
wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20251109T170053Z/stage3-amd64-openrc-20251109T170053Z.tar.xz > /dev/null 2>&1 && \
tar xvpf /mnt/gentoo/stage3-*.tar.xz -C /mnt/gentoo --xattrs-include='*.*' --numeric-owner > /dev/null 2>&1 && \
rm -rf /mnt/gentoo/stage3-*.tar.xz > /dev/null 2>&1 && \
echo "/dev/sda1 /boot vfat defaults 0 1
/dev/sda2 / ext4 defaults,noatime 0 1
/dev/sda3 /home ext4 defaults,noatime 0 2" > /mnt/gentoo/etc/fstab;


echo "criando pasta PORTAGE no diretorio /mnt/gentoo/home";
if mkdir -p /mnt/gentoo/home/PORTAGE; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "sobscrevendo arquivo make.conf para instalacao do gcc";
if echo 'COMMON_FLAGS="-O1 -pipe"
CFLAGS="-O1 -pipe"
CXXFLAGS="-O1 -pipe"
FCFLAGS="-O1 -pipe"
FFLAGS="-O1 -pipe"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
MAKEOPTS="-j64"
PORTAGE_TMPDIR="/home/PORTAGE"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
USE="wayland pulseaudio dbus -X -aqua -bluetooth -doc -gtk-doc -kde -plasma -systemd -selinux -audit -test -debug"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando partição swap temporario";
if fallocate -l 30G /mnt/gentoo/home/SWAP; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando permissões do diretorio /mnt/gentoo/SWAP";
if chmod 600 /mnt/gentoo/home/SWAP; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "formatando partição swap";
if mkswap /mnt/gentoo/home/SWAP; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "ativando swap";
if swapon /mnt/gentoo/home/SWAP; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando partição tmpfs no diretorio /var/tmp/portage";
if mount -t tmpfs -o size=100%,mode=1777 tmpfs /mnt/gentoo/var/tmp/portage; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando pasta package.mask no diretorio /mnt/gentoo/etc/portage";
if mkdir -p /mnt/gentoo/etc/portage/package.mask; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando bloqueio de instalação e atualização de pacotes não usados";
if echo "app-shells/fish
app-shells/zsh
app-shells/zsh-completions
kde-plasma/plasma-meta
kde-plasma/kde-apps-meta
kde-plasma/plasma-desktop
gnome-base/gdm
sys-apps/systemd" > /mnt/gentoo/etc/portage/package.mask/pacotes-nao-usados; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando pasta package.provided no diretorio /mnt/gentoo/etc/portage";
if mkdir -p /mnt/gentoo/etc/portage/package.provided; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando ignoração de verificação de pacotes não usados";
if echo "app-shells/fish
app-shells/zsh
app-shells/zsh-completions
kde-plasma/plasma-meta
kde-plasma/kde-apps-meta
kde-plasma/plasma-desktop
gnome-base/gdm
sys-apps/systemd" > /mnt/gentoo/etc/portage/package.provided/pacotes-nao-usados; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando pasta package.license no diretorio /mnt/gentoo/etc/portage";
if mkdir -p /mnt/gentoo/etc/portage/package.license; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando licença do pacote linux-firmware";
if echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" > /mnt/gentoo/etc/portage/package.license/linux-firmware; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando pasta package.accept_keywords no diretorio /etc/portage";
if mkdir -p /mnt/gentoo/etc/portage/package.accept_keywords; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "habilitando versões especificas de pacotes"
if echo "=sys-kernel/gentoo-sources-6.17.8
=sys-devel/gcc-15.2.1_p20251108-r1" > /mnt/gentoo/etc/portage/package.accept_keywords/PACOTES; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando pasta package.use no diretorio /mnt/gentoo/etc/portage";
if mkdir -p /mnt/gentoo/etc/portage/package.use; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "criando configuração do pacote";
if echo "sys-devel/gcc -nls -pie -ssp -libssp -rust -ada -cobol -fortran -go -d -modula2 -jit -debug -default-stack-clash-protection -valgrind -vtv -systemtap -cet -doc -zstd -test
sys-libs/glibc -ssp -static-pie -selinux -audit -debug -doc -systemd -nscd -systemtap -cet -test
dev-build/make -doc -nls -test
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
" > /mnt/gentoo/etc/portage/package.use/PACOTES; then


echo "adicionando fuso horario brasileiro";
if cp /mnt/gentoo/usr/share/zoneinfo/America/Sao_Paulo /mnt/gentoo/etc/localtime; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando identificador de fuso horario brasileiro";
if echo "America/Sao_Paulo" > /mnt/gentoo/etc/timezone; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando idioma e caracteres brasileiro";
if echo "pt_BR.UTF-8 UTF-8" > /mnt/gentoo/etc/locale.gen; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando suporte ipv6";
if echo "127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 bux.localdomain bux" > /mnt/gentoo/etc/hosts; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "copiando arquivo resolv.conf e colando no diretorio /etc";
if cp --dereference /etc/resolv.conf /mnt/gentoo/etc/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta proc";
if mount --types proc /proc /mnt/gentoo/proc/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta sys";
if mount --rbind /sys /mnt/gentoo/sys; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta sys novamente";
if mount --make-rslave /mnt/gentoo/sys; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta dev";
if mount --rbind /dev /mnt/gentoo/dev; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta dev novamente";
if mount --make-rslave /mnt/gentoo/dev; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta run";
if mount --bind /run /mnt/gentoo/run; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando pasta run novamente"
if mount --make-slave /mnt/gentoo/run; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "criando pasta repos.conf no diretorio /mnt/gentoo/etc/portage";
if mkdir --parents /mnt/gentoo/etc/portage/repos.conf; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "copiando arquivo repos.conf e colando em /mnt/gentoo/etc/portage/repos.conf";
if cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "aplicando mudanças de idiomas e caracteres brasileiro";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && locale-gen > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "sincronizando arvore de ebuilds do gentoo via web";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && emerge-webrsync --quiet > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "selecionando perfil do portage";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && eselect profile set 1 > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "sincronizando repositorios do portage";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && emerge --sync --quiet > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "instalando gcc";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && emerge --quiet =sys-devel/gcc-15.2.1_p20251108-r1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "sobscrevendo arquivo make.conf para instalação dos pacotes do sistema";
if echo 'COMMON_FLAGS="-O2 -march=native -mtune=native -fno-mudflap -pipe"
CFLAGS="-O2 -march=native -mtune=native -fno-mudflap -pipe"
CXXFLAGS="-O2 -march=native -mtune=native -fno-mudflap -pipe"
FCFLAGS="-O2 -march=native -mtune=native -fno-mudflap -pipe"
FFLAGS="-O2 -march=native -mtune=native -fno-mudflap -pipe"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
MAKEOPTS="-j64"
PORTAGE_TMPDIR="/home/PORTAGE"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
USE="wayland pulseaudio dbus -X -aqua -bluetooth -doc -gtk-doc -kde -plasma -systemd -selinux -audit -test -debug"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando pacotes importantes";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && emerge --quiet \
sys-libs/glibc \
sys-devel/binutils \
sys-apps/coreutils \
app-shells/bash \
sys-libs/ncurses \
sys-libs/readline \
sys-apps/file \
sys-kernel/linux-firmware \
sys-firmware/sof-firmware \
=sys-kernel/gentoo-sources-6.17.8 \
media-libs/mesa \
dev-libs/wayland \
gui-wm/sway \
gui-apps/wofi \
app-misc/fastfetch \
gui-apps/foot \
media-sound/pulseaudio-daemon \
media-sound/pavucontrol \
net-misc/networkmanager \
net-misc/dhcpcd \
sys-boot/grub \
sys-boot/efibootmgr \
@system; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "atualizando variáveis de ambiente globais";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && env-update; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "limpando kernel customizavel";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && make clean -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "limpando profundamente kernel customizavel";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && make mrproper -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando arquivo de configuração (.config)";
chroot /mnt/gentoo /bin/bash -c '
if source /etc/profile && make defconfig -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "configurando arquivo de configuração (.config)";
sed -i -E \
-e 's/^(# ?)?(CONFIG_ZPOOL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_SHRINKER_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZSMALLOC_STAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_BACKEND_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZORLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_DEFLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_DEF_COMP_842)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_WRITEBACK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_TRACK_ENTRY_ACTIME)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_MEMORY_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZRAM_MULTI_COMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CPU_MITIGATIONS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETPOLINE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETHUNK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_UNRET_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_IBPB_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_IBRS_ENTRY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SRSO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SLS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_GDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RFDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_BHI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_MDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_TAA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_MMIO_STALE_DATA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_L1TF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_RETBLEED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_V1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SPECTRE_V2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SRBDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_SSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_ITS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_TSA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MITIGATION_VMSCAPE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SUSPEND_FREEZER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ARCH_HIBERNATION_HEADER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATE_CALLBACKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_SNAPSHOT_DEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_COMP_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HIBERNATION_COMP_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_NOWAYOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_SYSFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SOFT_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CROS_EC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9052_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9055_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9063_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DA9062_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LENOVO_SE10_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LENOVO_SE30_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MENF21BMC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MENZ069_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WDAT_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WM831X_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WM8350_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XILINX_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZIIRAVE_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RAVE_SP_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MLX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CADENCE_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DW_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TWL4030_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX63XX_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RETU_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ACQUIRE_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADVANTECH_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADVANTECH_EC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ALIM1535_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ALIM7101_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CGBC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EBC_C384_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXAR_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F71808E_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SP5100_TCO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SBC_FITPC2_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EUROTECH_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IB700_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IBMASR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_WAFER_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_I6300ESB_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IE6XX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_OC_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ITCO_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ITCO_VENDOR_SUPPORT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IT8712F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IT87_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HPWDT_NMI_DECODING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KEMPLD_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SC1200_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PC87413_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NV_TCO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_60XX_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SMSC_SCH311X_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SMSC37B787_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TQMX86_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIA_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83627HF_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83877F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_W83977F_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MACHZ_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SBC_EPX_C3_WATCHDOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INTEL_MEI_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NI903X_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NIC7018_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SIEMENS_SIMATIC_IPC_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MEN_A21_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_WDT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_EXT3_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JBD2_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_FS_MBCACHE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_SECURITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JFS_STATISTICS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_SUPPORT_V4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_SUPPORT_ASCII_CI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_QUOTA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_RT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_DRAIN_INTENTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_LIVE_HOOKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_MEMORY_BUFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_BTREE_IN_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_SCRUB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_SCRUB_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_ONLINE_REPAIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_WARN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GFS2_FS_LOCKING_DLM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_O2CB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_USERSPACE_CLUSTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_FS_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_DEBUG_MASKLOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OCFS2_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_RUN_SANITY_TESTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_ASSERT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_EXPERIMENTAL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BTRFS_FS_REF_VERIFY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NILFS2_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_STAT_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_XATTR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_SECURITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_CHECK_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FAULT_INJECTION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_COMPRESSION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZORLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZ4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_LZ4HC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_FS_ZSTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_IOSTAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_F2FS_UNFAIR_RWSEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_QUOTA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_ERASURE_CODING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_TESTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_LOCK_TIME_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_NO_LATENCY_ACCT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_SIX_OPTIMISTIC_SPIN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_PATH_TRACEPOINTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_TRANS_KMALLOC_TRACE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_64BIT_CLUSTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_LZX_XPRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS3_FS_POSIX_ACL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NTFS_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE_BASE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RANDOMIZE_MEMORY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KASAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_VTL_MODE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_TIMER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_UTILS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERV_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MSHV_ROOT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AUDIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_BOOTPARAM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_DEVELOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_AVC_STATS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SECURITY_SELINUX_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_512GB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_SMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_DOM0)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM_SMP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVHVM_GUEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SAVE_RESTORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DOM0)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PV_MSR_SAFE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BALLOON_MEMORY_HOTPLUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SCRUB_PAGES_DEFAULT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_DEV_EVTCHN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XENFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_COMPAT_XENFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SYS_HYPERVISOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_XENBUS_FRONTEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GNTDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GNTDEV_DMABUF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DEV_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DMA_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SWIOTLB_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PCI_STUB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PCIDEV_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVCALLS_FRONTEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PVCALLS_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SCSI_BACKEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PRIVCMD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_PRIVCMD_EVENTFD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_ACPI_PROCESSOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_MCE_LOG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_HAVE_PVMMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_EFI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_AUTO_XLATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_ACPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_SYMS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_HAVE_VPMU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_FRONT_PGDIR_SHBUF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_UNPOPULATED_ALLOC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_GRANT_DMA_OPS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_XEN_VIRTIO_FORCE_GRANT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_88PM860X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_APU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_AW200XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_CHT_WCOVE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_CROS_EC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3530)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3532)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3642)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6323)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA9532)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA9532_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP3944)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP3952)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP50XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LP8788)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA955X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA955X_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA963X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PCA995X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_QNAP_MCU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_WM831X_STATUS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_WM8350)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DA903X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DA9052)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_DAC124S085)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PWM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_REGULATOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BD2606MVV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BD2802)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_INTEL_SS4200)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LT3593)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_ADP5520)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MC13783)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TCA6507)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TLC591XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MAX77705)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MAX8997)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM355x)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MENF21BMC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_IS31FL319X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_UPBOARD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BLINKM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_BLINKM_MULTICOLOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MLXREG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MLXCPLD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_USER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_NIC78BX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SPI_BYTE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TI_LMU_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM36274)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TPS6105X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_AS3645A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_LM3601X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6370_FLASH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_RT8515)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SGM3140)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_KTD202X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_PWM_MULTICOLOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_MT6370_RGB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGERS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TIMER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_ONESHOT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_DISK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_MTD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_HEARTBEAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_BACKLIGHT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_CPU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_ACTIVITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_GPIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_DEFAULT_ON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TRANSIENT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_CAMERA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_PANIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_NETDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_PATTERN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_TTY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_TRIGGER_INPUT_EVENTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_A11Y_BRAILLE_CONSOLE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BREDR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RFCOMM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RFCOMM_TTY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP_MC_FILTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BNEP_PROTO_FILTER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HIDP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LE_L2CAP_ECRED)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_6LOWPAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_LEDS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MSFTEXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_AOSPEXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_DEBUGFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_SELFTEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_QCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_AUTOSUSPEND)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_POLL_SYNC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_MTK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTUSB_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBTSDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_SERDEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_H4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_NOKIA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_BCSP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_ATH3K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_LL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_3WIRE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_BCM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_RTL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_QCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_AG6XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIUART_AML)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBCM203X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBCM4377)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBPA10X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBFUSB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIDTL1)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBT3C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIBLUECARD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIVHCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MRVL_SDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_ATH3K)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTKSDIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_MTKUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_HCIRSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_NXPUART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BT_INTEL_PCIE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISO9660_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JOLIET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZISOFS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_UDF_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INPUT_TABLET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_ACECAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_AIPTEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_HANWANG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_KBTAB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_USB_PEGASUS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TABLET_SERIAL_WACOM4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_INPUT_TOUCHSCREEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_88PM860X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ADS7846)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7877)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AD7879_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ADC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ATMEL_MXT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ATMEL_MXT_T37)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_AUO_PIXCIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_BU21013)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_BU21029)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CHIPONE_ICN8505)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CY8CTMA140)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CY8CTMG110)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_CYTTSP5)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DA9034)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DA9052)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_DYNAPRO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HAMPSHIRE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EETI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EXC3000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_FUJITSU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HIDEEP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HYCON_HY46XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ILI210X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ILITEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_S6SY761)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_GUNZE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EKTF2127)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ELAN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ELO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WACOM_W8001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WACOM_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MAX11801)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MMS114)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MELFAS_MIP4)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MSG2638)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IMAGIS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_INEXIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PENMOUNT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_EDT_FT5X06)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHRIGHT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHWIN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PIXCIR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WDT87XX_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM831X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM97XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9705)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9712)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_WM9713)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_COMPOSITE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_MC13783)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_EGALAX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_PANJIT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_3M)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ITM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ETURBO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GUNZE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_DMC_TSC10)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_IRTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_IDEALTEK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_GOTOP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_JASTEC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ELO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_E2I)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ZYTRONIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_ETT_TC45USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_NEXIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_USB_EASYTOUCH)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TOUCHIT213)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC_SERIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC200X_CORE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2004)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2005)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2007)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TSC2007_IIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_PCAP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_RM_TS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SILEAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SIS_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ST1232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_STMFTS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SUR40)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SURFACE3_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_SX8654)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_TPS6507X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZET6223)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZFORCE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_COLIBRI_VF50)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ROHM_BU21023)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IQS5XX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_IQS7211)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_ZINITIX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AFE4403)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AFE4404)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX30100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX30102)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AM2315)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DHT11)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ENS210)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC100X)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC2010)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HDC3020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_HUMIDITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTS221_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HTU21)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI7005)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI7020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ACPI_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADJD_S311)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ADUX1020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3000A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3010)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AL3320A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9160)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9300)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9306)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_APDS9960)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AS73211)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1745)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1750)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BH1780)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM32181)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3323)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM3605)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CM36651)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_CROS_EC_LIGHT_PROX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GP2AP002)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_GP2AP020A00F)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IQS621_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_ISL29018)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_ISL29028)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL29125)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL76682)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_ALS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_PROX)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_JSA1212)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ROHM_BU27034)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RPR0521)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_LM3533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTR390)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTR501)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LTRF216A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LV0104CS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX44000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MAX44009)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NOA1305)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT3001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT4001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_OPT4060)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PA12203001)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI1133)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SI1145)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_STK3310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ST_UVIS25_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TCS3414)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TCS3472)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SENSORS_TSL2563)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2583)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2591)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL2772)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_TSL4531)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_US5182D)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL4000)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL4035)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML3235)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6030)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6040)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6070)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VEML6075)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VL6180)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZOPT2201)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ABP060MG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ROHM_BM1390)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_BMP280_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_CROS_EC_BARO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DLHL60D)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DPS310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HID_SENSOR_PRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP03)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HSC030PA_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ICP10100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL115_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPL3115)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MPRLS0025PA_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5611_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MS5637)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SDP500)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IIO_ST_PRESS_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_T5403)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HP206C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ZPA2326_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AS3935)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_CROS_EC_MKBP_PROXIMITY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_D3323AA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HX9023S)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_IRSD200)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_ISL29501)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_LIDAR_LITE_V2)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_MB1232)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_RFD77402)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SRF04)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9310)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9324)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9360)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SX9500)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_SRF08)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VCNL3020)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VL53L0X_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_AW96103)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_KERNEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_INFO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_DEBUG_FS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_RING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_TASK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_IOTLB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_MENU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_NET)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_SCSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_VSOCK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_VDPA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_CROSS_ENDIAN_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_ANCHOR)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LIB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LIB_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MENU)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_ADMIN_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PCI_LEGACY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_VDPA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_PMEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_BALLOON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_INPUT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MMIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_DMA_SHARED_BUFFER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC_PTP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTIO_RTC_CLASS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_COMMON)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_PFNCACHE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQCHIP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQ_ROUTING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING_TSO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_MMIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_ASYNC_PF)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_MSI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_READONLY_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_VFIO)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_COMPAT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_IRQ_BYPASS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_NO_POLL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_XFER_TO_GUEST_WORK)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_PM_NOTIFIER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_HARDWARE_ENABLING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_MMU_NOTIFIER)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_MMU_LOCKLESS_AGING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_PRIVATE_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_GENERIC_PRIVATE_MEM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_VIRTUALIZATION)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_X86)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_INTEL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_X86_SGX_KVM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_AMD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_AMD_SEV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_IOAPIC)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_SMM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_HYPERV)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_XEN)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_KVM_EXTERNAL_WRITE_TRACKING)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_HYPERVISOR_GUEST)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_XXL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_DEBUG)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_PARAVIRT_SPINLOCKS)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_TRF7970A)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MEI_PHY)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_SIM)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PORT100)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_VIRTUAL_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_FDP)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_FDP_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN544_MEI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533_USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN533_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_PN532_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MICROREAD_MEI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_USB)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_MRVL_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST21NFCA)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST21NFCA_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST_NCI_SPI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_NXP_NCI)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_NXP_NCI_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN5)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN5_I2C)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_S3FWRN82_UART)(=.*| is not set)?$/\2=n/' \
-e 's/^(# ?)?(CONFIG_NFC_ST95HF)(=.*| is not set)?$/\2=n/' \
/mnt/gentoo/usr/src/linux*/.config;


echo "compilando kernel customizavel";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && yes n | make -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "instalando modulos do kernel customizavel";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && make modules_install -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "instalando kernel customizavel";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && make install -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "sobscrevendo arquivo make.conf para uso normal";
if echo 'COMMON_FLAGS="-O3 -march=native -mtune=native -fno-mudflap -pipe"
CFLAGS="-O3 -march=native -mtune=native -fno-mudflap -pipe"
CXXFLAGS="-O3 -march=native -mtune=native -fno-mudflap -pipe"
FCFLAGS="-O3 -march=native -mtune=native -fno-mudflap -pipe"
FFLAGS="-O3 -march=native -mtune=native -fno-mudflap -pipe"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
MAKEOPTS="-j64"
PORTAGE_TMPDIR="/home/PORTAGE"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
USE="wayland pulseaudio dbus -X -aqua -bluetooth -doc -gtk-doc -kde -plasma -systemd -selinux -audit -test -debug"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando nome bux ao usuario root";
if echo "hostname=\"bux\"" > /mnt/gentoo/etc/conf.d/hostname; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando senha bux ao usuario root";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && echo -e "bux\nbux" | passwd root; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando usuario normal com nome bux";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && useradd -m -g users -G wheel bux; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando senha bux ao usuario normal";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && echo -e "bux\nbux" | passwd bux; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando autostartx do kde plasma";
if echo "exec sway > /dev/null 2>&1" > /mnt/gentoo/home/bux/.bash_profile; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando diretorio de configuração do sway";
if mkdir -p /mnt/gentoo/home/bux/.config/sway; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando arquivo de configuração do sway";
if echo "set \$mod Mod4
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
include /etc/sway/config.d/*" > /mnt/gentoo/home/bux/.config/sway/config; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando diretorio de configuração extra do sway";
if mkdir -p /mnt/gentoo/etc/sway; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando arquivo de configuração extra do sway";
if echo "set \$mod Mod4
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
include /etc/sway/config.d/*" > /mnt/gentoo/etc/sway/config; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando suporte DHCP na inicializacao";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && rc-update add dhcpcd default; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando suporte NetworkManager na inicializacao";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && rc-update add NetworkManager default; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "sobscrevendo arquivo grub";
if echo "GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=\"BUX\"
GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"
GRUB_CMDLINE_LINUX=\"\"
GRUB_PRELOAD_MODULES=\"part_gpt part_msdos\"
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true" > /mnt/gentoo/etc/default/grub; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "configurando grub";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=. --recheck > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'


echo "adicionando grub na inicialização";
chroot /mnt/gentoo /bin/bash '
if source /etc/profile && grub-mkconfig -o /boot/grub/grub.cfg > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;'
