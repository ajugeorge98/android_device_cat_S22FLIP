#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
# Ensure clean ramdisk creation
LOCAL_POST_INSTALL_CMD := \
    $(hide) rm -rf $(TARGET_RECOVERY_ROOT_OUT)/etc && \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/etc

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_S22FLIP.mk

COMMON_LUNCH_CHOICES := \
    twrp_S22FLIP-user \
    twrp_S22FLIP-userdebug \
    twrp_S22FLIP-eng
