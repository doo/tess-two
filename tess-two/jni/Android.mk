ROOT_PATH := $(call my-dir)
LOCAL_PATH := $(call my-dir)

TESSERACT_PATH := $(LOCAL_PATH)/../../doo-tesseract
LEPTONICA_PATH := $(LOCAL_PATH)/com_googlecode_leptonica_android/src

ifeq ($(TARGET_ARCH_ABI), x86)
LIBJPEG_PATH := $(LOCAL_PATH)/libjpeg
else
LIBJPEG_PATH := $(LOCAL_PATH)/libjpeg-turbo
endif

# Just build the Android.mk files in the subdirs
include $(LIBJPEG_PATH)/Android.mk
LOCAL_PATH = $(ROOT_PATH)

include $(LOCAL_PATH)/com_googlecode_leptonica_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)

include $(LOCAL_PATH)/com_googlecode_tesseract_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)
