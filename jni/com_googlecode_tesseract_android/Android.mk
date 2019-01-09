LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libtess

# tesseract (minus executable)

BLACKLIST_SRC_FILES := \
  %api/tesseractmain.cpp \
  %viewer/svpaint.cpp

TESSERACT_SRC_FILES := \
  $(wildcard $(TESSERACT_PATH)/api/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/arch/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/ccmain/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/ccstruct/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/ccutil/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/classify/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/cutil/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/dict/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/lstm/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/textord/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/viewer/*.cpp) \
  $(wildcard $(TESSERACT_PATH)/wordrec/*.cpp)

LOCAL_SRC_FILES := \
  $(filter-out $(BLACKLIST_SRC_FILES),$(subst $(LOCAL_PATH)/,,$(TESSERACT_SRC_FILES)))

LOCAL_C_INCLUDES := \
  $(TESSERACT_PATH)/api \
  $(TESSERACT_PATH)/arch \
  $(TESSERACT_PATH)/ccmain \
  $(TESSERACT_PATH)/ccstruct \
  $(TESSERACT_PATH)/ccutil \
  $(TESSERACT_PATH)/classify \
  $(TESSERACT_PATH)/cutil \
  $(TESSERACT_PATH)/dict \
  $(TESSERACT_PATH)/lstm \
  $(TESSERACT_PATH)/opencl \
  $(TESSERACT_PATH)/textord \
  $(TESSERACT_PATH)/viewer \
  $(TESSERACT_PATH)/wordrec \
  $(LEPTONICA_PATH)/src

LOCAL_CFLAGS := \
  -DGRAPHICS_DISABLED \
  --std=c++11 \
  -DUSE_STD_NAMESPACE \
  -D'VERSION="Android"' \
  -include ctype.h \
  -include unistd.h \
  -fpermissive \
  -Wno-deprecated \
  -Wno-shift-negative-value \
  -D_GLIBCXX_PERMIT_BACKWARD_HASH   # fix for android-ndk-r8e/sources/cxx-stl/gnu-libstdc++/4.6/include/ext/hash_map:61:30: fatal error: backward_warning.h: No such file or directory

ifeq ($(APP_OPTIM),debug)
  LOCAL_CFLAGS += -O0 -UNDEBUG
  $(info Tesseract: Debug build)
else
  LOCAL_CFLAGS += -O3 -DNDEBUG
  $(info Tesseract: Release build)
endif

ifneq ($(findstring arm,$(TARGET_ARCH)),)
  $(info Tesseract: using NEON instructions)
  LOCAL_ARM_NEON := true
  LOCAL_CFLAGS += -D__ARM_NEON__
endif

# jni

LOCAL_SRC_FILES += \
  pageiterator.cpp \
  resultiterator.cpp \
  tessbaseapi.cpp

LOCAL_C_INCLUDES += \
  $(LOCAL_PATH)

LOCAL_LDLIBS += \
  -latomic \
  -ljnigraphics \
  -llog

# common

LOCAL_PRELINK_MODULE := false
LOCAL_SHARED_LIBRARIES := liblept
LOCAL_DISABLE_FORMAT_STRING_CHECKS := true

include $(BUILD_SHARED_LIBRARY)
