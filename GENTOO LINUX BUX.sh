#!/bin/bash

echo "formatando 1 disco valido";
wipefs -a /dev/sda && \
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
echo "PASSOU";


echo "baixando stage3";
if wget -P /mnt/gentoo https://distfiles.gentoo.org/releases/amd64/autobuilds/20250907T165007Z/stage3-amd64-openrc-20250907T165007Z.tar.xz > /dev/null 2>&1; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "extraindo stage3";
if tar xvpf /mnt/gentoo/stage3-amd64-openrc-20250907T165007Z.tar.xz -C /mnt/gentoo --xattrs-include='*.*' --numeric-owner > /dev/null 2>&1; then
echo "PASSOU"
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
MAKEOPTS="-j16"
EMERGE_DEFAULT_OPTS="--keep-going=y --autounmask-write=y"
USE="-systemd -gnome -kde -oss -pipeware -dvd"
LC_MESSAGES=C.utf8
GENTOO_MIRRORS="http://gentoo.c3sl.ufpr.br/"' > /mnt/gentoo/etc/portage/make.conf; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "copiando arquivo resolv.conf e colando no diretorio /etc";
if cp --dereference /etc/resolv.conf /mnt/gentoo/etc/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta proc";
if mount --types proc /proc /mnt/gentoo/proc/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta sys";
if mount --rbind /sys /mnt/gentoo/sys; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta sys novamente";
if mount --make-rslave /mnt/gentoo/sys; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta dev";
if mount --rbind /dev /mnt/gentoo/dev; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta dev novamente";
if mount --make-rslave /mnt/gentoo/dev; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta run";
if mount --bind /run /mnt/gentoo/run; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "montando pasta run novamente"
if mount --make-slave /mnt/gentoo/run; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "criando pasta repos.conf no diretorio /mnt/gentoo/etc/portage";
if mkdir --parents /mnt/gentoo/etc/portage/repos.conf; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "copiando arquivo repos.conf e colando em /mnt/gentoo/etc/portage/repos.conf";
if cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "entrando no ambiente chroot"
chroot /mnt/gentoo /bin/bash -c '
echo "PASSOU";

echo "adicionando perfil de configuração";
if source /etc/profile; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "sincronizando arvore de ebuilds do gentoo via web";
if emerge-webrsync --quiet > /dev/null 2>&1; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "selecionando perfil do portage";
if eselect profile set 1 > /dev/null 2>&1; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "sincronizando repositorios do portage";
if emerge --sync --quiet > /dev/null 2>&1; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "desativando recursos obsoletos ou pouco usados do gcc"
if echo "sys-devel/gcc -mudflap -doc -nls" > /etc/portage/package.use/gcc; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "atualizando pacotes";
if emerge --quiet --verbose --update --deep --changed-use @world; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "adicionando licença do pacote linux-firmware";
if echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" > /etc/portage/package.license; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "instalando pacote linux-firmware";
if emerge --quiet sys-kernel/linux-firmware; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


echo "instalando pacote sof-firmware";
if emerge --quiet sys-firmware/sof-firmware; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo "Sao_Paulo" > /etc/timezone; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if locale-gen > /dev/null 2>&1; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if env-update; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if emerge --quiet sys-kernel/gentoo-sources; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if make clean -j16 -C /usr/src/linux*/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if make mrproper -j16 -C /usr/src/linux*/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if make defconfig -j16 -C /usr/src/linux*/; then
echo "PASSOU"
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

if make -j16 -C /usr/src/linux*/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if make modules_install -j16 -C /usr/src/linux*/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if make install -j16 -C /usr/src/linux*/; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo "/dev/sda1 /boot vfat defaults 0 1
/dev/sda2 / ext4 defaults,noatime 0 1
/dev/sda3 /home ext4 defaults,noatime 0 2" > /etc/fstab; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo "hostname="bux"" > /etc/conf.d/hostname; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo -e "bux\nbux" | passwd root; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if useradd -m -g users -G wheel bux; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo -e "bux\nbux" | passwd bux; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if echo "127.0.0.1 localhost.localdomain localhost
::1 localhost.localdomain localhost
127.0.0.1 bux.localdomain bux" > /etc/hosts; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if emerge --quiet dhcpcd; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;


if rc-update add dhcpcd default; then
echo "PASSOU"
else
echo "FALHOU" && exit
fi;'
