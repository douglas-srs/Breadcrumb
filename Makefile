export THEOS_DEVICE_IP=192.168.1.111 THEOS_DEVICE_PORT=22
THEOS_BUILD_DIR = Packages
ARCHS = armv7 arm64
include theos/makefiles/common.mk

FRAMEWORK_NAME = Breadcrumb
Breadcrumb_FILES = Breadcrumb.xm DSBreadcrumb.mm DSGlobal.m
Breadcrumb_INSTALL_PATH = /Library/Frameworks
Breadcrumb_FRAMEWORKS = UIKit MobileCoreServices
Breadcrumb_PRIVATE_FRAMEWORKS = AppSupport
Breadcrumb_PUBLIC_HEADERS = DSBreadcrumb.h
Breadcrumb_LIBRARIES = substrate rocketbootstrap

include $(THEOS_MAKE_PATH)/framework.mk

after-Breadcrumb-all::
	# create directories
	mkdir -p $(THEOS_OBJ_DIR)/Breadcrumb.framework/Headers

	# copy headers
	rsync -ra $(Breadcrumb_PUBLIC_HEADERS) $(THEOS_OBJ_DIR)/Breadcrumb.framework/Headers

	# copy to theos lib dir
	rsync -ra $(THEOS_OBJ_DIR)/Breadcrumb.framework $(THEOS)/lib

after-Breadcrumb-stage::
	# create directories
	mkdir -p $(THEOS_STAGING_DIR)/usr/{include,lib}

	# breadcrumb.dylib -> Breadcrumb.framework
	ln -s /Library/Frameworks/Breadcrumb.framework/Breadcrumb $(THEOS_STAGING_DIR)/usr/lib/breadcrumb.dylib

	# Breadcrumb -> Breadcrumb.framework/Headers
	ln -s /Library/Frameworks/Breadcrumb.framework/Headers $(THEOS_STAGING_DIR)/usr/include/Breadcrumb

	# Breadcrumb -> breadcrumb.dylib
	mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries
	ln -s /Library/Frameworks/Breadcrumb.framework/Breadcrumb $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/breadcrumb.dylib
	cp Breadcrumb.plist $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/breadcrumb.plist

after-install::
	install.exec "killall -9  backboardd || killall -9 SpringBoard;"
