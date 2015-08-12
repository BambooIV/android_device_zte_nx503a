#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from nx507j device
$(call inherit-product, device/zte/nx507j/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nx507j
PRODUCT_BRAND := zte
PRODUCT_MODEL := nx507j
PRODUCT_MANUFACTURER := zte

TARGET_VENDOR := zte 
TARGET_VENDOR_PRODUCT_NAME := nx507j
TARGET_VENDOR_DEVICE_NAME := nx507j
