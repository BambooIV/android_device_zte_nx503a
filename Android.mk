ifneq ($(filter nx503a,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)
include $(call all-makefiles-under,$(LOCAL_PATH))

$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/bcm4339; \
        ln -sf fw_bcmdhd_apsta.bin\
        $(TARGET_OUT_ETC)/firmware/bcm4339/fw_bcmdhd.bin )

endif
