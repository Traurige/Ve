TWEAK_NAME = VeSettings
$(TWEAK_NAME)_FILES = VeSettings.x $(wildcard Controllers/*.m) $(wildcard Custom-Cells/*.m)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -DTHEOS_LEAN_AND_MEAN
$(TWEAK_NAME)_FRAMEWORKS = UIKit
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
