#
# Copyright (C) 2016 The CyanogenMod Project
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

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
TARGET_BOOTANIMATION_HALF_RES := true

# Inherit device configuration
$(call inherit-product, device/zte/nx503a/nx503a.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nx503a
PRODUCT_NAME := cm_nx503a
PRODUCT_BRAND := nubia
PRODUCT_MODEL := NX503A
PRODUCT_MANUFACTURER := nubia

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=NX503A \
    PRODUCT_NAME=NX503A \
    BUILD_FINGERPRINT=nubia/NX503A/NX503A:4.4.2/KVT49L/eng.nubia.20150120.194044:user/release-keys \
    PRIVATE_BUILD_DESC="NX503A-user 4.4.2 KVT49L eng.nubia.20150120.194044 release-keys"
