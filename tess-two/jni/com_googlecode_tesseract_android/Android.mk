LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libtess

# tesseract (minus executable)

BLACKLIST_SRC_FILES := \
  %api/tesseractmain.cpp \
  %ccstruct/imagedata.cpp \
  %viewer/svpaint.cpp

TESSERACT_SRC_FILES := \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/api/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/ccmain/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/ccstruct/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/ccutil/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/classify/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/cube/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/cutil/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/dict/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/opencl/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/neural_networks/runtime/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/textord/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/viewer/*.cpp) \
  $(wildcard $(LOCAL_PATH)/$(TESSERACT_PATH)/wordrec/*.cpp)

LOCAL_SRC_FILES := \
  $(filter-out $(BLACKLIST_SRC_FILES),$(subst $(LOCAL_PATH)/,,$(TESSERACT_SRC_FILES)))

LOCAL_C_INCLUDES := \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/api \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/ccmain \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/ccstruct \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/ccutil \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/classify \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/cube \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/cutil \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/dict \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/opencl \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/neural_networks/runtime \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/textord \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/viewer \
  $(LOCAL_PATH)/$(TESSERACT_PATH)/wordrec \
  $(LEPTONICA_PATH)/src

LOCAL_CFLAGS := \
  -DHAVE_LIBLEPT \
  -DGRAPHICS_DISABLED \
  -DUSE_STD_NAMESPACE \
  -D'VERSION="Android"' \
  -include ctype.h \
  -include unistd.h \
  -fpermissive \
  -Wno-deprecated \
  -O3 \
  -D_GLIBCXX_PERMIT_BACKWARD_HASH   # fix for android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.6/include/ext/hash_map:61:30: fatal error: backward_warning.h: No such file or directory

#--std=c++11 x86 and mips doesn't support it
ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += --std=c++11
endif

# jni

LOCAL_SRC_FILES += \
  pageiterator.cpp \
  resultiterator.cpp \
  tessbaseapi.cpp

LOCAL_C_INCLUDES += \
  $(LOCAL_PATH)

LOCAL_LDLIBS += \
  -ljnigraphics \
  -llog

LOCAL_CFLAGS += -fopenmp
LOCAL_LDFLAGS += -fopenmp

# common

LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblept
LOCAL_DISABLE_FORMAT_STRING_CHECKS := true

include $(BUILD_SHARED_LIBRARY)
