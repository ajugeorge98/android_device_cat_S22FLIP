#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),S22FLIP)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif

# Add this to your device tree's build configuration
LOCAL_POST_INSTALL_CMD := \
    $(hide) rm -rf $(TARGET_RECOVERY_ROOT_OUT)/etc && \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/etc
