#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable project quotas and casefold for A13+ emulated storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit TWRP common configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from S22FLIP device
$(call inherit-product, device/cat/S22FLIP/device.mk)

# Device identifier
PRODUCT_DEVICE := S22FLIP
PRODUCT_NAME := twrp_S22FLIP
PRODUCT_BRAND := Cat
PRODUCT_MODEL := S22 FLIP
PRODUCT_MANUFACTURER := cat

# Copy prebuilt binaries to recovery sbin
PRODUCT_COPY_FILES += \
    device/cat/S22FLIP/prebuilt/sbin/mkfs.ext4:recovery/root/sbin/mkfs.ext4 \
    device/cat/S22FLIP/prebuilt/sbin/parted:recovery/root/sbin/parted

# TWRP specific build properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=qm215 \
    ro.treble.enabled=true \
    persist.sys.usb.config=mtp,adb \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    ro.secure=0 \
    ro.allow.mock.location=0

# Additional TWRP configurations
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb

# Device characteristics
PRODUCT_CHARACTERISTICS := default,phone

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.msm8917 \
    bootctrl.msm8917.recovery

# Crypto configurations
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# F2FS tools
PRODUCT_PACKAGES += \
    fsck.f2fs \
    mkfs.f2fs

# Additional recovery tools
PRODUCT_PACKAGES += \
    toybox \
    libion \
    strace

# OEM security patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.version.security_patch=$(PLATFORM_SECURITY_PATCH)

# Build fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="S22FLIP-user 11 RKQ1.210416.002 LTE_S02113.11_N_S22Flip_0.030.03 release-keys"

BUILD_FINGERPRINT := Cat/S22FLIP/S22FLIP:11/RKQ1.210416.002/LTE_S02113.11_N_S22Flip_0.030.03:user/release-keys

# Override recovery size for small-screen device
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.width=480 \
    ro.twrp.height=640 \
    ro.twrp.density=286

# Enable USB OTG if supported
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.isUsbOtgEnabled=true

# Disable treble error
PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=false

# For mount point for vendor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.fingerprint=$(BUILD_FINGERPRINT)

# Enable FBE/ICE for Android 11
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.metadata.method=ice
