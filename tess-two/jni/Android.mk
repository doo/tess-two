ROOT_PATH := $(call my-dir)
LOCAL_PATH := $(call my-dir)

TESSERACT_PATH := $(LOCAL_PATH)/tesseract
LEPTONICA_PATH := $(LOCAL_PATH)/com_googlecode_leptonica_android/src

# NOTE: Disable image loading libraries because Tesseract is always fed raw images and never image files
# LIBPNG_PATH := $(LOCAL_PATH)/libpng

# ifeq ($(TARGET_ARCH_ABI), x86)
# LIBJPEG_PATH := $(LOCAL_PATH)/libjpeg
# else
# LIBJPEG_PATH := $(LOCAL_PATH)/libjpeg-turbo
# endif

# # Just build the Android.mk files in the subdirs
# include $(LIBJPEG_PATH)/Android.mk
# LOCAL_PATH = $(ROOT_PATH)

# include $(LIBPNG_PATH)/Android.mk
# LOCAL_PATH = $(ROOT_PATH)

include $(LOCAL_PATH)/com_googlecode_leptonica_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)

include $(LOCAL_PATH)/com_googlecode_tesseract_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)
