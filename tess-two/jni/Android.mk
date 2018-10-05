ROOT_PATH := $(call my-dir)
LOCAL_PATH := $(call my-dir)

TESSERACT_PATH := $(LOCAL_PATH)/tesseract
LEPTONICA_PATH := $(LOCAL_PATH)/com_googlecode_leptonica_android/src

include $(LOCAL_PATH)/com_googlecode_leptonica_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)

include $(LOCAL_PATH)/com_googlecode_tesseract_android/Android.mk
LOCAL_PATH = $(ROOT_PATH)
