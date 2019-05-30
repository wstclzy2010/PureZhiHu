INSTALL_TARGET_PROCESSES = osee2unifiedRelease

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = pureZhiHu

pureZhiHu_FILES = Tweak.x
pureZhiHu_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
