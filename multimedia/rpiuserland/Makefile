#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=raspberrypi-userland
PKG_VERSION:=20150909
PKG_VERSION:=20180318
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/raspberrypi/userland.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=cc92dfd6c4e8e2d90c3903dccfe77f7274b8d1b7
PKG_SOURCE_VERSION:=eb3e6d7b3d2ae585318c1c16055e3cecedceee4b
PKG_SOURCE_PROTO:=git

PKG_LICENSE:=BSD 3-Clause
PKG_LICENSE_FILES:=LICENCE
PKG_MAINTAINER:=Plonkbong <plonkbong100@protonmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/version.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/raspicam
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Capturing video with the Raspberry-Pi camera module.
  URL:=https://github.com/raspberrypi/userland
  DEPENDS+= +kmod-video-bcm2835 +libpthread +librt +libstdcpp +libc 
  #+brcm2708-gpu-fw +kmod-hwmon-bcm2835 +kmod-i2c-bcm2835 +kmod-random-bcm2835 +kmod-smi-bcm2835-dev +kmod-sound-arm-bcm2835 +kmod-sound-soc-bcm2835-i2s +kmod-spi-bcm2835-aux +kmod-spi-bcm2835 +kmod-i2c-bcm2708 +rpiuserland-rest
endef

define Package/rpiuserland-rest
	SECTION:=utils
	CATEGORY:=Utilities
	URL:=https://github.com/raspberrypi/userland
	TITLE:=the rest of the rpiuserland that are not contain in raspicam.
	DEPENDS+= +raspicam
endef

define Package/raspicam/description
recording tools for the Raspberry-Pi camera module
endef



define Package/rpiuserland-rest/description
the rest of the rpiuserland that are not contain in raspicam.
endef

define Package/description/$(PKG_NAME)
The Linpack benchmark code measures floating point computation performance. 
It was developed as part of the Linpack matrix library. For more information, see the Linpack Benchmark FAQ.
This code has been modified only to compile and run on the Raspberry Pi and Mac OS X.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_BUILD_DIR)/build/inc $(1)/usr/include
	
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/*.{a,so*} $(1)/usr/lib/
	
	$(CP) $(PKG_BUILD_DIR)/ipkg-install/opt $(1)
endef



define Package/raspicam/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libmmal_core.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libmmal_util.so $(1)/usr/lib	
	$(CP) $(PKG_BUILD_DIR)/build/lib/libmmal_vc_client.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libvcos.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libbcm_host.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libvcsm.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libvchiq_arm.so $(1)/usr/lib
	#$(CP) $(PKG_BUILD_DIR)/build/lib/libEGL.so $(1)/usr/lib
	#$(CP) $(PKG_BUILD_DIR)/build/lib/libGLESv2.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libbrcmEGL.so $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/build/lib/libbrcmGLESv2.so $(1)/usr/lib
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/build/bin/raspivid $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/build/bin/raspividyuv $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/build/bin/raspiyuv $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/build/bin/raspistill $(1)/usr/bin
endef



define Package/rpiuserland-rest/install
	$(INSTALL_DIR) $(1)/usr
	$(CP) $(PKG_BUILD_DIR)/build/lib $(1)/usr/
	$(CP) $(PKG_BUILD_DIR)/build/bin $(1)/usr/
	
	$(RM) $(1)/usr/lib/libmmal_core.so
	$(RM) $(1)/usr/lib/libmmal_util.so
	$(RM) $(1)/usr/lib/libmmal_vc_client.so
	$(RM) $(1)/usr/lib/libvcos.so
	$(RM) $(1)/usr/lib/libbcm_host.so
	$(RM) $(1)/usr/lib/libvcsm.so
	$(RM) $(1)/usr/lib/libvchiq_arm.so
	#$(RM) $(1)/usr/lib/libEGL.so
	#$(RM) $(1)/usr/lib/libGLESv2.so
	$(RM) $(1)/build/lib/libbrcmEGL.so
	$(RM) $(1)/build/lib/libbrcmGLESv2.so
	$(RM) $(1)/usr/lib/*.a
	
	$(RM) $(1)/usr/bin/raspivid
	$(RM) $(1)/usr/bin/raspividyuv
	$(RM) $(1)/usr/bin/raspiyuv
	$(RM) $(1)/usr/bin/raspistill
endef



$(eval $(call BuildPackage,raspicam))
$(eval $(call BuildPackage,rpiuserland-rest))