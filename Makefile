export THEOS_DEVICE_IP=192.168.1.111 THEOS_DEVICE_PORT=22
THEOS_BUILD_DIR = Packages
ARCHS = armv7 arm64
include theos/makefiles/common.mk

FRAMEWORK_NAME = libBreadcrumb
libBreadcrumb_FILES = libBreadcrumb.xm UIBreadcrumbActionItem.mm LBGlobal.m
libBreadcrumb_INSTALL_PATH = /Library/Frameworks
libBreadcrumb_FRAMEWORKS = UIKit MobileCoreServices
libbreadcrumb_PRIVATE_FRAMEWORKS = AppSupport
libBreadcrumb_PUBLIC_HEADERS = UIBreadcrumbActionItem.h
libBreadcrumb_LIBRARIES = substrate rocketbootstrap

include $(THEOS_MAKE_PATH)/framework.mk

after-libBreadcrumb-all::
	# create directories
	mkdir -p $(THEOS_OBJ_DIR)/libBreadcrumb.framework/Headers

	# copy headers
	rsync -ra $(libBreadcrumb_PUBLIC_HEADERS) $(THEOS_OBJ_DIR)/libBreadcrumb.framework/Headers

	# copy to theos lib dir
	rsync -ra $(THEOS_OBJ_DIR)/libBreadcrumb.framework $(THEOS)/lib

after-libBreadcrumb-stage::
	# create directories
	mkdir -p $(THEOS_STAGING_DIR)/usr/{include,lib}

	# libbreadcrumb.dylib -> libBreadcrumb.framework
	ln -s /Library/Frameworks/libBreadcrumb.framework/libBreadcrumb $(THEOS_STAGING_DIR)/usr/lib/libbreadcrumb.dylib

	# libBreadcrumb -> libBreadcrumb.framework/Headers
	ln -s /Library/Frameworks/libBreadcrumb.framework/Headers $(THEOS_STAGING_DIR)/usr/include/libBreadcrumb

	# libBreadcrumb -> libbreadcrumb.dylib
	mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries
	ln -s /Library/Frameworks/libBreadcrumb.framework/libBreadcrumb $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/libbreadcrumb.dylib
	cp libbreadcrumb.plist $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/libbreadcrumb.plist

after-install::
	install.exec "killall -9 SpringBoard;"
