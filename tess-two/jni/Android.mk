LOCAL_PATH := $(call my-dir)

TESSERACT_PATH := ../../../doo-tesseract
LEPTONICA_PATH := $(LOCAL_PATH)/com_googlecode_leptonica_android/src
LIBJPEG_PATH := $(LOCAL_PATH)/libjpeg-turbo

# Just build the Android.mk files in the subdirs
include $(call all-subdir-makefiles)
