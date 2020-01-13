INSTALL_TARGET_PROCESSES = osee2unifiedRelease

TARGET = iPhone:latest:11.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = pureZhiHu

pureZhiHu_FILES = Tweak.x src/PZHURLProtocol.m
pureZhiHu_CFLAGS = -fobjc-arc -Isrc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk
