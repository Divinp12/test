#!/bin/bash

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
if wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20251005T161859Z/stage3-amd64-openrc-20251005T161859Z.tar.xz > /dev/null 2>&1; then
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


echo "sobscrevendo arquivo make.conf";
if echo 'COMMON_FLAGS="-Ofast -flto -march=native -pipe"
CFLAGS="-Ofast -flto -march=native -pipe"
CXXFLAGS="-Ofast -flto -march=native -pipe"
FCFLAGS="-Ofast -flto -march=native -pipe"
FFLAGS="-Ofast -flto -march=native -pipe"
RUSTFLAGS="${RUSTFLAGS} -C target-cpu=native"
MAKEOPTS="-j64"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
USE="-X -bluetooth -doc"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
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


echo "instalando pacotes essenciais";
if emerge --quiet \
sys-devel/gcc \
sys-libs/glibc \
app-shells/bash \
sys-apps/coreutils; then
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


echo "adicionando licença do pacote linux-firmware";
if echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" > /etc/portage/package.license; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando pacote linux-firmware";
if emerge --quiet sys-kernel/linux-firmware; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando pacote sof-firmware";
if emerge --quiet sys-firmware/sof-firmware; then
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


echo "atualizando variáveis de ambiente globais";
if env-update; then
echo ""
else
echo "FALHOU" && exit
fi;


echo "instalando kernel customizavel";
if emerge --quiet sys-kernel/gentoo-sources; then
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


sed -i "s/^.*CONFIG_SWAP.*$/CONFIG_SWAP=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_ZSWAP.*$/CONFIG_ZSWAP=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_ZRAM.*$/CONFIG_ZRAM=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_CPU_MITIGATIONS.*$/CONFIG_CPU_MITIGATIONS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.*$/CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_RETPOLINE.*$/CONFIG_MITIGATION_RETPOLINE=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_RETHUNK.*$/CONFIG_MITIGATION_RETHUNK=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_UNRET_ENTRY.*$/CONFIG_MITIGATION_UNRET_ENTRY=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_CALL_DEPTH_TRACKING.*$/CONFIG_MITIGATION_CALL_DEPTH_TRACKING=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_IBPB_ENTRY.*$/CONFIG_MITIGATION_IBPB_ENTRY=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_IBRS_ENTRY.*$/CONFIG_MITIGATION_IBRS_ENTRY=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SRSO.*$/CONFIG_MITIGATION_SRSO=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SLS.*$/CONFIG_MITIGATION_SLS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_GDS.*$/CONFIG_MITIGATION_GDS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_RFDS.*$/CONFIG_MITIGATION_RFDS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SPECTRE_BHI.*$/CONFIG_MITIGATION_SPECTRE_BHI=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_MDS.*$/CONFIG_MITIGATION_MDS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_TAA.*$/CONFIG_MITIGATION_TAA=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_MMIO_STALE_DATA.*$/CONFIG_MITIGATION_MMIO_STALE_DATA=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_L1TF.*$/CONFIG_MITIGATION_L1TF=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_RETBLEED.*$/CONFIG_MITIGATION_RETBLEED=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SPECTRE_V1.*$/CONFIG_MITIGATION_SPECTRE_V1=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SPECTRE_V2.*$/CONFIG_MITIGATION_SPECTRE_V2=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SRBDS.*$/CONFIG_MITIGATION_SRBDS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_SSB.*$/CONFIG_MITIGATION_SSB=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_MITIGATION_ITS.*$/CONFIG_MITIGATION_ITS=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_WATCHDOG.*$/CONFIG_WATCHDOG=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_WATCHDOG_CORE.*$/CONFIG_WATCHDOG_CORE=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED.*$/CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_SUSPEND.*$/CONFIG_SUSPEND=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_SUSPEND_FREEZER.*$/CONFIG_SUSPEND_FREEZER=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_HIBERNATE_CALLBACKS.*$/CONFIG_HIBERNATE_CALLBACKS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_HIBERNATION.*$/CONFIG_HIBERNATION=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_HIBERNATION_SNAPSHOT_DEV.*$/CONFIG_HIBERNATION_SNAPSHOT_DEV=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_HIBERNATION_COMP_LZO.*$/CONFIG_HIBERNATION_COMP_LZO=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_EXT2_FS.*$/CONFIG_EXT2_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_EXT3_FS.*$/CONFIG_EXT3_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_JFS_FS.*$/CONFIG_JFS_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_XFS_FS.*$/CONFIG_XFS_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_GFS2_FS.*$/CONFIG_GFS2_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_BTRFS_FS.*$/CONFIG_BTRFS_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_NILFS2_FS.*$/CONFIG_NILFS2_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_F2FS_FS.*$/CONFIG_F2FS_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_BCACHEFS_FS.*$/CONFIG_BCACHEFS_FS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_NTFS_FS.*$/CONFIG_NTFS_FS=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_RANDOMIZE_BASE.*$/CONFIG_RANDOMIZE_BASE=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_RANDOMIZE_MEMORY.*$/CONFIG_RANDOMIZE_MEMORY=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_DEBUG_KERNEL.*$/CONFIG_DEBUG_KERNEL=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_MISC.*$/CONFIG_DEBUG_MISC=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_LIST.*$/CONFIG_DEBUG_LIST=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_PLIST.*$/CONFIG_DEBUG_PLIST=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_SG.*$/CONFIG_DEBUG_SG=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_NOTIFIERS.*$/CONFIG_DEBUG_NOTIFIERS=n/" /usr/src/linux*/.config;
sed -i "s/^.*CONFIG_DEBUG_MAPLE_TREE.*$/CONFIG_DEBUG_MAPLE_TREE=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_KASAN.*$/CONFIG_KASAN=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_HYPERV.*$/CONFIG_HYPERV=n/" /usr/src/linux*/.config;

sed -i "s/^.*CONFIG_AUDIT.*$/CONFIG_AUDIT=n/" /usr/src/linux*/.config;

sudo sed -i "s/^.*CONFIG_SECURITY_SELINUX.*$/CONFIG_SECURITY_SELINUX=n/" .config;
sudo sed -i "s/^.*CONFIG_SECURITY_SELINUX_DEBUG.*$/CONFIG_SECURITY_SELINUX_DEBUG=n/" .config;
sudo sed -i "s/^.*CONFIG_SECURITY_SELINUX_BOOTPARAM.*$/CONFIG_SECURITY_SELINUX_BOOTPARAM=n/" .config;
sudo sed -i "s/^.*CONFIG_SECURITY_SELINUX_DEVELOP.*$/CONFIG_SECURITY_SELINUX_DEVELOP=n/" .config;
sudo sed -i "s/^.*CONFIG_SECURITY_SELINUX_AVC_STATS.*$/CONFIG_SECURITY_SELINUX_AVC_STATS=n/" .config;

sudo sed -i "s/^.*CONFIG_XEN.*$/CONFIG_XEN=n/" .config;

sudo sed -i "s/^.*CONFIG_LEDS_APU.*$/CONFIG_LEDS_APU=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_AW200XX.*$/CONFIG_LEDS_AW200XX=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_LM3530.*$/CONFIG_LEDS_LM3530=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_LM3532.*$/CONFIG_LEDS_LM3532=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_LM3642.*$/CONFIG_LEDS_LM3642=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_PCA9532.*$/CONFIG_LEDS_PCA9532=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_LP3944.*$/CONFIG_LEDS_LP3944=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_PCA955X.*$/CONFIG_LEDS_PCA955X=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_PCA963X.*$/CONFIG_LEDS_PCA963X=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_PCA995X.*$/CONFIG_LEDS_PCA995X=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_BD2606MVV.*$/CONFIG_LEDS_BD2606MVV=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_BD2802.*$/CONFIG_LEDS_BD2802=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_INTEL_SS4200.*$/CONFIG_LEDS_INTEL_SS4200=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_TCA6507.*$/CONFIG_LEDS_TCA6507=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_TLC591XX.*$/CONFIG_LEDS_TLC591XX=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_LM355x.*$/CONFIG_LEDS_LM355x=n/" .config;
sudo sed -i "s/^.*CONFIG_LEDS_IS31FL319X.*$/CONFIG_LEDS_IS31FL319X=n/" .config;

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
