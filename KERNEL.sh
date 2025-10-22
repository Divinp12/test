#!/bin/bash

sudo pacman -Sy --noconfirm bc coreutils cpio gettext initramfs kmod libelf ncurses pahole perl python3 tar xz wget && \
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.54.tar.xz && \
sudo tar -xvpf linux-6.12.54.tar.xz --xattrs-include='*.*' --numeric-owner && \
cd linux-6.12.54 && \
sudo make clean -j64 && \
sudo make mrproper -j64 && \
sudo make defconfig -j64;


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
.config

CONFIG_MITIGATION_UNRET_ENTRY=y
CONFIG_MITIGATION_CALL_DEPTH_TRACKING=y
CONFIG_MITIGATION_IBPB_ENTRY=y
CONFIG_MITIGATION_IBRS_ENTRY=y
CONFIG_MITIGATION_SRSO=y
CONFIG_MITIGATION_SLS=y
CONFIG_MITIGATION_GDS=y
CONFIG_MITIGATION_RFDS=y
CONFIG_MITIGATION_SPECTRE_BHI=y
CONFIG_MITIGATION_MDS=y
CONFIG_MITIGATION_TAA=y
CONFIG_MITIGATION_MMIO_STALE_DATA=y
CONFIG_MITIGATION_L1TF=y
CONFIG_MITIGATION_RETBLEED=y
CONFIG_MITIGATION_SPECTRE_V1=y
CONFIG_MITIGATION_SPECTRE_V2=y
CONFIG_MITIGATION_SRBDS=y
CONFIG_MITIGATION_SSB=y
CONFIG_MITIGATION_ITS=y
CONFIG_MITIGATION_TSA=y
CONFIG_MITIGATION_VMSCAPE=y

CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_HIBERNATION_COMP_LZO=y
# CONFIG_HIBERNATION_COMP_LZ4 is not set
CONFIG_HIBERNATION_DEF_COMP="lzo"

#DESATIVAR WATCHDOG
sudo sed -Ei '/CONFIG_WATCHDOG/ s/.*(CONFIG_WATCHDOG[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_SOFT_WATCHDOG/ s/.*(CONFIG_SOFT_WATCHDOG[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS EXT2
sudo sed -Ei '/CONFIG_EXT2/ s/.*(CONFIG_EXT2[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS EXT3
sudo sed -Ei '/CONFIG_EXT3/ s/.*(CONFIG_EXT3[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS JFS
sudo sed -Ei '/CONFIG_JFS/ s/.*(CONFIG_JFS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS XFS
sudo sed -Ei '/CONFIG_XFS/ s/.*(CONFIG_XFS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS GFS2
sudo sed -Ei '/CONFIG_GFS2/ s/.*(CONFIG_GFS2[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS BTRFS
sudo sed -Ei '/CONFIG_BTRFS/ s/.*(CONFIG_BTRFS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS NILFS2
sudo sed -Ei '/CONFIG_NILFS2/ s/.*(CONFIG_NILFS2[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS F2FS
sudo sed -Ei '/CONFIG_F2FS/ s/.*(CONFIG_F2FS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS BCACHEFS
sudo sed -Ei '/CONFIG_BCACHEFS/ s/.*(CONFIG_BCACHEFS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR FORMATO DE ARQUIVOS NTFS
sudo sed -Ei '/CONFIG_NTFS/ s/.*(CONFIG_NTFS[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR RANDOMIZAÇÃO DE MEMORIA
sudo sed -Ei '/CONFIG_RANDOMIZE/ s/.*(CONFIG_RANDOMIZE[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR DEBUG
sudo sed -Ei '/CONFIG_DEBUG/ s/.*(CONFIG_DEBUG[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR KASAN
sudo sed -Ei '/CONFIG_KASAN/ s/.*(CONFIG_KASAN[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR HYPERV
sudo sed -Ei '/CONFIG_HYPERV/ s/.*(CONFIG_HYPERV[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_MSHV_ROOT/ s/.*(CONFIG_MSHV_ROOT[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR AUDIT
sudo sed -Ei '/CONFIG_AUDIT/ s/.*(CONFIG_AUDIT[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR SELINUX
sudo sed -Ei '/CONFIG_SECURITY_SELINUX/ s/.*(CONFIG_SECURITY_SELINUX[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR XEN
sudo sed -Ei '/CONFIG_XEN/ s/.*(CONFIG_XEN[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_SWIOTLB_XEN/ s/.*(CONFIG_SWIOTLB_XEN[A-Z0-9_]*).*/\1=n/' .config;

#DESATIVAR DRIVERS DE LEDS
sudo sed -Ei '/CONFIG_LEDS/ s/.*(CONFIG_LEDS[A-Z0-9_]*).*/\1=n/' .config;

# DESATIVAR SUPORTE BLUETOOTH
sudo sed -Ei '/CONFIG_BT/ s/.*(CONFIG_BT[A-Z0-9_]*).*/\1=n/' .config;

# DESATIVAR SISTEMA DE ARQUIVOS CD-ROM E DVD
sudo sed -Ei '/CONFIG_ISO9660_FS/ s/.*(CONFIG_ISO9660_FS[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_JOLIET/ s/.*(CONFIG_JOLIET[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_ZISOFS/ s/.*(CONFIG_ZISOFS[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_UDF_FS/ s/.*(CONFIG_UDF_FS[A-Z0-9_]*).*/\1=n/' .config;

# DESATIVAR TOUCHSCREEN
sudo sed -Ei '/CONFIG_INPUT_TOUCHSCREEN/ s/.*(CONFIG_INPUT_TOUCHSCREEN[A-Z0-9_]*).*/\1=n/' .config;
sudo sed -Ei '/CONFIG_TOUCHSCREEN/ s/.*(CONFIG_TOUCHSCREEN[A-Z0-9_]*).*/\1=n/' .config;

# Light sensors
#
#CONFIG_ACPI_ALS=m
#CONFIG_ADJD_S311=m
#CONFIG_ADUX1020=m
#CONFIG_AL3000A=m
#CONFIG_AL3010=m
#CONFIG_AL3320A=m
#CONFIG_APDS9160=m
#CONFIG_APDS9300=m
#CONFIG_APDS9306=m
#CONFIG_APDS9960=m
#CONFIG_AS73211=m
#CONFIG_BH1745=m
#CONFIG_BH1750=m
#CONFIG_BH1780=m
#CONFIG_CM32181=m
#CONFIG_CM3232=m
#CONFIG_CM3323=m
#CONFIG_CM3605=m
#CONFIG_CM36651=m
#CONFIG_IIO_CROS_EC_LIGHT_PROX=m
#CONFIG_GP2AP002=m
#CONFIG_GP2AP020A00F=m
#CONFIG_IQS621_ALS=m
#CONFIG_SENSORS_ISL29018=m
#CONFIG_SENSORS_ISL29028=m
#CONFIG_ISL29125=m
#CONFIG_ISL76682=m
#CONFIG_HID_SENSOR_ALS=m
#CONFIG_HID_SENSOR_PROX=m
#CONFIG_JSA1212=m
#CONFIG_ROHM_BU27034=m
#CONFIG_RPR0521=m
#CONFIG_SENSORS_LM3533=m
#CONFIG_LTR390=m
#CONFIG_LTR501=m
#CONFIG_LTRF216A=m
#CONFIG_LV0104CS=m
#CONFIG_MAX44000=m
#CONFIG_MAX44009=m
#CONFIG_NOA1305=m
#CONFIG_OPT3001=m
#CONFIG_OPT4001=m
#CONFIG_OPT4060=m
#CONFIG_PA12203001=m
#CONFIG_SI1133=m
#CONFIG_SI1145=m
#CONFIG_STK3310=m
#CONFIG_ST_UVIS25=m
#CONFIG_ST_UVIS25_I2C=m
#CONFIG_ST_UVIS25_SPI=m
#CONFIG_TCS3414=m
#CONFIG_TCS3472=m
#CONFIG_SENSORS_TSL2563=m
#CONFIG_TSL2583=m
#CONFIG_TSL2591=m
#CONFIG_TSL2772=m
#CONFIG_TSL4531=m
#CONFIG_US5182D=m
#CONFIG_VCNL4000=m
#CONFIG_VCNL4035=m
#CONFIG_VEML3235=m
#CONFIG_VEML6030=m
#CONFIG_VEML6040=m
#CONFIG_VEML6070=m
#CONFIG_VEML6075=m
#CONFIG_VL6180=m
#CONFIG_ZOPT2201=m
# end of Light sensors

# Pressure sensors
#
#CONFIG_ABP060MG=m
#CONFIG_ROHM_BM1390=m
#CONFIG_BMP280=m
#CONFIG_BMP280_I2C=m
#CONFIG_BMP280_SPI=m
#CONFIG_IIO_CROS_EC_BARO=m
#CONFIG_DLHL60D=m
#CONFIG_DPS310=m
#CONFIG_HID_SENSOR_PRESS=m
#CONFIG_HP03=m
#CONFIG_HSC030PA=m
#CONFIG_HSC030PA_I2C=m
#CONFIG_HSC030PA_SPI=m
#CONFIG_ICP10100=m
#CONFIG_MPL115=m
#CONFIG_MPL115_I2C=m
#CONFIG_MPL115_SPI=m
#CONFIG_MPL3115=m
#CONFIG_MPRLS0025PA=m
#CONFIG_MPRLS0025PA_I2C=m
#CONFIG_MPRLS0025PA_SPI=m
#CONFIG_MS5611=m
#CONFIG_MS5611_I2C=m
#CONFIG_MS5611_SPI=m
#CONFIG_MS5637=m
#CONFIG_SDP500=m
#CONFIG_IIO_ST_PRESS=m
#CONFIG_IIO_ST_PRESS_I2C=m
#CONFIG_IIO_ST_PRESS_SPI=m
#CONFIG_T5403=m
#CONFIG_HP206C=m
#CONFIG_ZPA2326=m
#CONFIG_ZPA2326_I2C=m
#CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

# Lightning sensors
#
#CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
#CONFIG_CROS_EC_MKBP_PROXIMITY=m
#CONFIG_D3323AA=m
#CONFIG_HX9023S=m
#CONFIG_IRSD200=m
#CONFIG_ISL29501=m
#CONFIG_LIDAR_LITE_V2=m
#CONFIG_MB1232=m
#CONFIG_PING=m
#CONFIG_RFD77402=m
#CONFIG_SRF04=m
#CONFIG_SX_COMMON=m
#CONFIG_SX9310=m
#CONFIG_SX9324=m
#CONFIG_SX9360=m
#CONFIG_SX9500=m
#CONFIG_SRF08=m
#CONFIG_VCNL3020=m
#CONFIG_VL53L0X_I2C=m
#CONFIG_AW96103=m
# end of Proximity and distance sensors

sudo make -j64 && \
sudo make modules_install -j64 && \
sudo make install -j64 && \
sudo mv arch/x86/boot/bzImage /boot/vmlinuz-6.12.54 && \
sudo mkinitcpio -k $(make -s kernelversion) -g /boot/initramfs-6.12.54.img && \
sudo mkinitcpio -P && \
sudo grub-mkconfig -o /boot/grub/grub.cfg
