#!/bin/bash

clear && \
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
echo "";


echo "baixando stage3";
if wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20251026T170339Z/stage3-amd64-openrc-20251026T170339Z.tar.xz > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "extraindo stage3";
if tar xvpf /mnt/gentoo/stage3-*.tar.xz -C /mnt/gentoo --xattrs-include='*.*' --numeric-owner > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "deletando stage3";
if rm -rf /mnt/gentoo/stage3-*.tar.xz > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


#COMMON_FLAGS="-Ofast -flto -march=native -mtune=native -fno-pie -no-pie -fno-stack-protector -fno-stack-protector-strong -fomit-frame-pointer -fno-ident -fno-unwind-tables -fno-asynchronous-unwind-tables -g0 -pipe"

echo "sobscrevendo arquivo make.conf";
if echo 'COMMON_FLAGS="-O1 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
MAKEOPTS="-j64"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
PORTAGE_TMPDIR="/var/tmp/portage"
USE="-X -bluetooth -doc -kde -plasma -systemd"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
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


echo "adicionando licença do pacote linux-firmware";
if echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" > /mnt/gentoo/etc/portage/package.license; then
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


echo "habilitando versao 6.17.5 do pacote gentoo-sources"
if echo "=sys-kernel/gentoo-sources-6.17.5 ~amd64" > /mnt/gentoo/etc/portage/package.accept_keywords/kernel; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando partição swap temporaria de 30gb";
if fallocate -l 30G /mnt/gentoo/home/ST; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "alterando permissões no swap";
if chmod 600 /mnt/gentoo/home/ST; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "formatando arquivo de partição swap";
if mkswap /mnt/gentoo/home/ST; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "ativando swap";
if swapon /mnt/gentoo/home/ST; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando diretorio /var/tmp/portage";
if mkdir -p /mnt/gentoo/var/tmp/portage; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "montando partição tmpfs temporaria do diretorio /var/tmp/portage";
if mount -t tmpfs -o size=100%,noatime tmpfs /mnt/gentoo/var/tmp/portage; then
echo ""
else
echo "FALHOU" && exit
fi;


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


echo "entrando no ambiente chroot"
chroot /mnt/gentoo /bin/bash -c '
echo "";

echo "adicionando perfil de configuração";
if source /etc/profile; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "aplicando mudanças de idiomas e caracteres brasileiro";
if locale-gen > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "sincronizando arvore de ebuilds do gentoo via web";
if emerge-webrsync --quiet > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "selecionando perfil do portage";
if eselect profile set 1 > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "sincronizando repositorios do portage";
if emerge --sync --quiet > /dev/null 2>&1; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando pacotes importantes";
if emerge --quiet \
sys-devel/gcc \
sys-libs/glibc \
sys-devel/gettext \
sys-apps/coreutils \
sys-apps/bash \
sys-devel/binutils \
sys-libs/ncurses \
sys-libs/readline \
sys-apps/file \
sys-libs/pam \
dev-libs/libffi \
app-crypt/gpgme \
dev-libs/libxml2
sys-kernel/linux-firmware
sys-firmware/sof-firmware
=sys-kernel/gentoo-sources-6.17.5; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "atualizando pacotes";
if emerge --quiet --verbose --update --deep --changed-use @world; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "atualizando variáveis de ambiente globais";
if env-update; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "limpando kernel customizavel";
if make clean -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;

echo "limpando profundamente kernel customizavel";
if make mrproper -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando arquivo de configuração (.config)";
if make defconfig -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;

######

echo "compilando kernel customizavel";
if make -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando modulos do kernel customizavel";
if make modules_install -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando kernel customizavel";
if make install -j64 -C /usr/src/linux*/; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando partições em fstab";
if echo "/dev/sda1 /boot vfat defaults 0 1
/dev/sda2 / ext4 defaults,noatime 0 1
/dev/sda3 /home ext4 defaults,noatime 0 2" > /etc/fstab; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando nome bux ao usuario root";
if echo "hostname="bux"" > /etc/conf.d/hostname; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando senha bux ao usuario root";
if echo -e "bux\nbux" | passwd root; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando usuario normal com nome bux";
if useradd -m -g users -G wheel bux; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando senha bux ao usuario normal";
if echo -e "bux\nbux" | passwd bux; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando pacote de suporte DHCP";
if emerge --quiet dhcpcd; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "adicionando suporte DHCP na inicializacao";
if rc-update add dhcpcd default; then
echo ""
else
echo "FALHOU" && exit
fi;'
