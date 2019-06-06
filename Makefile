INSTALL_TARGET_PROCESSES = osee2unifiedRelease

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = pureZhiHu

pureZhiHu_FILES = Tweak.x src/PZHURLProtocol.m
pureZhiHu_CFLAGS = -fobjc-arc -Isrc

include $(THEOS_MAKE_PATH)/tweak.mk
