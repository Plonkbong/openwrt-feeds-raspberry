#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gst1-rtsp-server
PKG_VERSION:=1.15.2
PKG_RELEASE:=1

PKG_MAINTAINER:=Plonkbong <plonkbong100@protonmail.com>

PKG_LICENSE:=LGPLv2
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DIR:=$(BUILD_DIR)/gst-rtsp-server-$(PKG_VERSION)
PKG_SOURCE:=gst-rtsp-server-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://gstreamer.freedesktop.org/src/gst-rtsp-server/
PKG_HASH:=11d455f6ac8544eb8d8a014a1046d284800c1c80c93ae6b43b20a5fd1921b4c5

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk



define Package/$(PKG_NAME)
  CATEGORY:=Multimedia
  SECTION:=multimedia
  TITLE:=GStreamer1 RTSP server
  URL:=http://gstreamer.freedesktop.org/
  DEPENDS:= +libgstreamer1 $(ICONV_DEPENDS) +gstreamer1-plugins-base
endef

define Package/$(PKG_NAME)-examples
$(call Package/$(PKG_NAME))
  TITLE+= the examples
  DEPENDS+= +$(PKG_NAME)
endef



define Package/$(PKG_NAME)/description
 GStreamer open source multimedia framework
 This package contains the libraries for RTSP server libraries
endef


define Package/$(PKG_NAME)-examples/description
$(call Package/$(PKG_NAME)/description)
 .
 This package contains only the binary examples
endef


CONFIGURE_ARGS += \
	--disable-fatal-warnings


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.{la,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/gstreamer-1.0/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/gstreamer-1.0/*.{la,so*} $(1)/usr/lib/gstreamer-1.0
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) -a $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/* $(1)/usr/lib/pkgconfig/
	
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) -a $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/lib/include/
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/gstreamer-1.0/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/gstreamer-1.0/*.so* $(1)/usr/lib/gstreamer-1.0
endef


define Package/$(PKG_NAME)-examples/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_BUILD_DIR)/examples/.libs/* $(1)/usr/bin
endef 


$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-examples))
