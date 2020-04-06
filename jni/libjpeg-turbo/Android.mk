LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libjpgt

ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard x86),)
LOCAL_ARM_NEON := true
LOCAL_CFLAGS += -D__ARM_HAVE_NEON
endif

LOCAL_ASMFLAGS += -DELF

ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_SRC_FILES += \
	simd/jsimd_x86_64.c \
	simd/jfdctflt-sse-64.asm \
	simd/jccolor-sse2-64.asm \
	simd/jcgray-sse2-64.asm \
	simd/jcsample-sse2-64.asm \
	simd/jdcolor-sse2-64.asm \
	simd/jdmerge-sse2-64.asm \
	simd/jdsample-sse2-64.asm \
	simd/jfdctfst-sse2-64.asm \
	simd/jfdctint-sse2-64.asm \
	simd/jidctflt-sse2-64.asm \
	simd/jidctfst-sse2-64.asm \
	simd/jidctint-sse2-64.asm \
	simd/jidctred-sse2-64.asm \
	simd/jquantf-sse2-64.asm \
	simd/jquanti-sse2-64.asm \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SRC_FILES += \
	simd/jsimd_i386.c \
	simd/jsimdcpu.asm \
	simd/jfdctflt-3dn.asm \
	simd/jidctflt-3dn.asm \
	simd/jquant-3dn.asm \
	simd/jccolor-mmx.asm \
	simd/jcgray-mmx.asm \
	simd/jcsample-mmx.asm \
	simd/jdcolor-mmx.asm \
	simd/jdmerge-mmx.asm \
	simd/jdsample-mmx.asm \
	simd/jfdctfst-mmx.asm \
	simd/jfdctint-mmx.asm \
	simd/jidctfst-mmx.asm \
	simd/jidctint-mmx.asm \
	simd/jidctred-mmx.asm \
	simd/jquant-mmx.asm \
	simd/jfdctflt-sse.asm \
	simd/jidctflt-sse.asm \
	simd/jquant-sse.asm \
	simd/jccolor-sse2.asm \
	simd/jcgray-sse2.asm \
	simd/jcsample-sse2.asm \
	simd/jdcolor-sse2.asm \
	simd/jdmerge-sse2.asm \
	simd/jdsample-sse2.asm \
	simd/jfdctfst-sse2.asm \
	simd/jfdctint-sse2.asm \
	simd/jidctflt-sse2.asm \
	simd/jidctfst-sse2.asm \
	simd/jidctint-sse2.asm \
	simd/jidctred-sse2.asm \
	simd/jquantf-sse2.asm \
	simd/jquanti-sse2.asm \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

LOCAL_ASMFLAGS += -DPIC

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard),)
LOCAL_SRC_FILES += \
	simd/jsimd_arm.c \
	simd/jsimd_arm_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),armeabi)
LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
	simd/jsimd_arm64.c \
	simd/jsimd_arm64_neon.S \

LOCAL_CFLAGS += \
	-DSIZEOF_SIZE_T=8 \

endif

# libjpeg_la_SOURCES from Makefile.am
LOCAL_SRC_FILES += \
	jcapimin.c \
	jcapistd.c \
	jccoefct.c \
	jccolor.c \
	jcdctmgr.c \
	jchuff.c \
	jcinit.c \
	jcmainct.c \
	jcmarker.c \
	jcmaster.c \
	jcomapi.c \
	jcparam.c \
	jcphuff.c \
	jcprepct.c \
	jcsample.c \
	jctrans.c \
	jdapimin.c \
	jdapistd.c \
	jdatadst.c \
	jdatasrc.c \
	jdcoefct.c \
	jdcolor.c \
	jddctmgr.c \
	jdhuff.c \
	jdinput.c \
	jdmainct.c \
	jdmarker.c \
	jdmaster.c \
	jdmerge.c \
	jdphuff.c \
	jdpostct.c \
	jdsample.c \
	jdtrans.c \
	jerror.c \
	jfdctflt.c \
	jfdctfst.c \
	jfdctint.c \
	jidctflt.c \
	jidctfst.c \
	jidctint.c \
	jidctred.c \
	jquant1.c \
	jquant2.c \
	jutils.c \
	jmemmgr.c \
	jmemnobs.c \

# if WITH_ARITH_ENC from Makefile.am
LOCAL_SRC_FILES += \
	jaricom.c \
	jcarith.c \
	jdarith.c \

# libturbojpeg_la_SOURCES from Makefile.am
LOCAL_SRC_FILES += \
	turbojpeg.c \
	transupp.c \
	jdatadst-tj.c \
	jdatasrc-tj.c \

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/simd \

LOCAL_EXPORT_C_INCLUDES := \
	$(LOCAL_PATH) \

LOCAL_CFLAGS += \
	-DC_ARITH_CODING_SUPPORTED=1 \
	-DD_ARITH_CODING_SUPPORTED=1 \
	-DBITS_IN_JSAMPLE=8 \
	-DHAVE_DLFCN_H=1 \
	-DHAVE_INTTYPES_H=1 \
	-DHAVE_LOCALE_H=1 \
	-DHAVE_MEMCPY=1 \
	-DHAVE_MEMORY_H=1 \
	-DHAVE_MEMSET=1 \
	-DHAVE_STDDEF_H=1 \
	-DHAVE_STDINT_H=1 \
	-DHAVE_STDLIB_H=1 \
	-DHAVE_STRINGS_H=1 \
	-DHAVE_STRING_H=1 \
	-DHAVE_SYS_STAT_H=1 \
	-DHAVE_SYS_TYPES_H=1 \
	-DHAVE_UNISTD_H=1 \
	-DHAVE_UNSIGNED_CHAR=1 \
	-DHAVE_UNSIGNED_SHORT=1 \
	-DINLINE="inline __attribute__((always_inline))" \
	-DJPEG_LIB_VERSION=62 \
	-DMEM_SRCDST_SUPPORTED=1 \
	-DNEED_SYS_TYPES_H=1 \
	-DSTDC_HEADERS=1 \
	-DWITH_SIMD=1 \
	-Wno-shift-negative-value -Wno-implicit-function-declaration

LOCAL_EXPORT_CFLAGS += \
  	-DC_ARITH_CODING_SUPPORTED=1 \
  	-DD_ARITH_CODING_SUPPORTED=1 \
  	-DBITS_IN_JSAMPLE=8 \
  	-DHAVE_DLFCN_H=1 \
  	-DHAVE_INTTYPES_H=1 \
  	-DHAVE_LOCALE_H=1 \
  	-DHAVE_MEMCPY=1 \
  	-DHAVE_MEMORY_H=1 \
  	-DHAVE_MEMSET=1 \
  	-DHAVE_STDDEF_H=1 \
  	-DHAVE_STDINT_H=1 \
  	-DHAVE_STDLIB_H=1 \
  	-DHAVE_STRINGS_H=1 \
  	-DHAVE_STRING_H=1 \
  	-DHAVE_SYS_STAT_H=1 \
  	-DHAVE_SYS_TYPES_H=1 \
  	-DHAVE_UNISTD_H=1 \
  	-DHAVE_UNSIGNED_CHAR=1 \
  	-DHAVE_UNSIGNED_SHORT=1 \
  	-DINLINE="inline __attribute__((always_inline))" \
  	-DJPEG_LIB_VERSION=62 \
  	-DMEM_SRCDST_SUPPORTED=1 \
  	-DNEED_SYS_TYPES_H=1 \
  	-DSTDC_HEADERS=1 \
  	-DWITH_SIMD=1 \

include $(BUILD_SHARED_LIBRARY)
