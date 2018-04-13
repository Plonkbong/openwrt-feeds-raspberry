#
# Copyright (C) 2008-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libgudev
PKG_VERSION:=232
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://download.gnome.org/sources/libgudev/$(PKG_VERSION)
PKG_HASH:=ee4cb2b9c573cdf354f6ed744f01b111d4b5bed3503ffa956cefff50489c7860

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL:=1

PKG_LICENSE:=LGPL-2
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Plonkbong <plonkbong100@protonmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/libgudev
  TITLE:=GObject bindings for libudev
  SECTION:=libs
  CATEGORY:=Libraries
  URL:=https://wiki.gnome.org/Projects/libgudev
  DEPENDS:= +libudev +glib2
endef

define Package/libgudev/description
  This library provides GObject bindings for libudev. It was originally part of udev-extras, then udev, then systemd. Its now a project on its own.
endef

CONFIGURE_ARGS += \
	--disable-umockdev \



define Build/InstallDev
	$(INSTALL_DIR) $(1)/
	$(CP) -a $(PKG_INSTALL_DIR)/* $(1)/
endef

define Package/libgudev/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libgudev))