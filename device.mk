#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Bootctrl
PRODUCT_PACKAGES += \
    bootctrl.default \
    android.hardware.boot@1.1-impl \
    android.hardware.boot@1.1-service \
    android.hardware.boot@1.1.recovery

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# first_stage_ramdisk
PRODUCT_COPY_FILES += \
    device/xiaomi/pissarro/vendor_overlay/etc/fstab.mt6877:$(TARGET_COPY_OUT_RECOVERY)/first_stage_ramdisk/fstab.emmc \
    device/xiaomi/pissarro/vendor_overlay/etc/fstab.mt6877:$(TARGET_COPY_OUT_RECOVERY)/first_stage_ramdisk/fstab.mt6877 

# Init
PRODUCT_COPY_FILES += \
    device/xiaomi/pissarro/rootdir/etc/init.mt6877.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/init.mt6877.rc 

# Vendor_overlay
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/xiaomi/pissarro/vendor_overlay,$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/30/)

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure.recovery=0

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 30

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)