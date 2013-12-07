#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# common 8960 configs
$(call inherit-product, device/htc/msm8960-common/msm8960.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/totemc2/overlay

# Bootanimation
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.tc2 \
    init.tc2.rc \
    init.tc2.usb.rc \
    remount.tc2 \
    ueventd.tc2.rc

# Qualcomm scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init.qcom.bt.sh:/system/etc/init.qcom.bt.sh \
    $(LOCAL_PATH)/configs/init.qcom.fm.sh:/system/etc/init.qcom.fm.sh \
    $(LOCAL_PATH)/configs/init.qcom.post_boot.sh:/system/etc/init.qcom.post_boot.sh \
    $(LOCAL_PATH)/configs/init.qcom.q6_links.sh:/system/etc/init.qcom.q6_links.sh \
    $(LOCAL_PATH)/configs/init.qcom.radio_links.sh:/system/etc/init.qcom.radio_links.sh \

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermald.conf:system/etc/thermald.conf

# Vold config
PRODUCT_COPY_FILE += \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab

PRODUCT_PACKAGES += \
    libnetcmdiface

# Audio configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/dsp/snd_soc_msm/snd_soc_msm_Sitar:/system/etc/snd_soc_msm/snd_soc_msm_Sitar \
    $(LOCAL_PATH)/configs/AudioBTID.csv:system/etc/AudioBTID.csv \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf

# Media config
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# Keylayouts and Keychars
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/synaptics-rmi-touchscreen.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl \
    $(LOCAL_PATH)/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    $(LOCAL_PATH)/keylayout/keypad_8960.kl:system/usr/keylayout/keypad_8960.kl \
    $(LOCAL_PATH)/keylayout/projector-Keypad.kl:system/usr/keylayout/projector-Keypad.kl

# Input device config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    $(LOCAL_PATH)/idc/projector_input.idc:system/usr/idc/projector_input.idc

# NFCEE access control
#ifeq ($(TARGET_BUILD_VARIANT),user)
#    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access.xml
#else
#    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/configs/nfcee_access_debug.xml
#endif
#PRODUCT_COPY_FILES += \
#    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# Camera
PRODUCT_PACKAGES += \
    camera.msm8960

# GPS
PRODUCT_PACKAGES += \
    libloc_adapter \
    libloc_eng \
    libloc_api_v02 \
    libgps.utils \
    gps.msm8960 

# GPS config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf

# Torch
PRODUCT_PACKAGES += \
    Torch

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb

PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true \
    persist.gps.qmienabled=true \
    ro.opengles.version=196608 \
    ro.baseband.arch=msm \

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/fstab.tc2:recovery/root/fstab.tc2

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc \
    choice_fn \
    power_test \
    offmode_charging \
    detect_key

# We have enough space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set build date
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# call the proprietary setup
$(call inherit-product-if-exists, vendor/htc/totemc2/totemc2-vendor.mk)
