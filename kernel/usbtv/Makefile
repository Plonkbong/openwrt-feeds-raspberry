#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=video-usbtv
PKG_RELEASE:=1
PKG_LICENSE:=GPLv2

KERNELSRC_URL=https://cdn.kernel.org/pub/linux/kernel/v4.x/
KERNELSRC_FILE=linux-$(LINUX_VERSION).tar.xz
KERNELSRC_DRV_DIR=$(LINUX_DIR)/drivers/media/usb/usbtv

include $(INCLUDE_DIR)/package.mk

define KernelPackage/video-usbtv
  SUBMENU:=Video Support
  TITLE:=usbtv webcam support
  DEPENDS:=@USB_SUPPORT +kmod-video-core +kmod-video-videobuf2 +kmod-sound-core
  FILES:=$(KERNELSRC_DRV_DIR)/usbtv.ko
  AUTOLOAD:=$(call AutoProbe,usbtv)
  # PKGFLAGS should normaly at PKGFLAGS:=nonshared or better disable by # because it is the default
  PKGFLAGS:=shared
endef

define KernelPackage/video-usbtv/description
  Kernelmodule for usbtv007 videograbber.
endef

# this ?
#EXTRA_KCONFIG:= \
	CONFIG_MEDIA_USB_SUPPORT=y \
	CONFIG_MEDIA_CAMERA_SUPPORT=y \
	CONFIG_VIDEO_USBTV=m
# or this ?
	
EXTRA_KCONFIG:= \
	CONFIG_VIDEO_USBTV=m
	
# better

EXTRA_CFLAGS:= \
	$(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=m,%,$(filter %=m,$(EXTRA_KCONFIG)))) \
	$(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=y,%,$(filter %=y,$(EXTRA_KCONFIG)))) \

MAKE_OPTS:= \
	$(KERNEL_MAKE_FLAGS) \
	SUBDIRS="$(KERNELSRC_DRV_DIR)" \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(EXTRA_KCONFIG)
	
define Download/kernelsource
	URL:=$(KERNELSRC_URL)
	FILE:=$(KERNELSRC_FILE)
	#HASH:= # from where did i know ?
endef
	
define Build/Prepare
	$(call Build/Prepare/Default)
	
	$(RM) -r $(KERNELSRC_DRV_DIR) # this works correctly
	echo "$(wildcard $(KERNELSRC_DRV_DIR)/Makefile)" # this works sometimes why ?
	read
	
  ifeq ("$(wildcard $(KERNELSRC_DRV_DIR)/Makefile)","") # this fail sometimes because wildcard does not wor correctly
		$(eval $(call Download,kernelsource))
		mkdir -p $(LINUX_DIR)
		( $(TAR) -kxf $(DL_DIR)/$(KERNELSRC_FILE) --strip=1 -C $(LINUX_DIR) || exit 0; )
  endif
endef

define Build/Compile
	# what is the best ?
	## $(KERNEL_MAKE) SUBDIRS="$(PKG_BUILD_DIR)" modules
	
	$(MAKE) -C "$(LINUX_DIR)" \
		$(MAKE_OPTS) \
		modules
		
	##$(MAKE_KMOD) -C "$(LINUX_DIR)" \
	##	SUBDIRS="$(PKG_BUILD_DIR)/glue" \
	##	modules
endef

$(eval $(call KernelPackage,video-usbtv))
