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

# Cleanup and prepare recovery etc directory
LOCAL_POST_INSTALL_CMD := \
    $(hide) rm -rf $(TARGET_RECOVERY_ROOT_OUT)/etc && \
    mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/etc

# Set permissions for prebuilt executables
LOCAL_POST_INSTALL_CMD := $(foreach s,$(LOCAL_PREBUILT_EXECUTABLES),chmod 755 $(TARGET_OUT)/sbin/$(notdir $(s));)

include $(CLEAR_VARS)
LOCAL_MODULE := sbin_perms_fix
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := prebuilt/sbin/verify_perms.sh
include $(BUILD_PREBUILT)
