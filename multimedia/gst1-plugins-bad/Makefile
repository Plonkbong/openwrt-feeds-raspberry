#
# Copyright (C) 2011-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gst1-plugins-bad
PKG_VERSION:=1.15.2
PKG_RELEASE:=1

PKG_MAINTAINER:=W. Michael Petullo <mike@flyn.org> \
		Ted Hess <thess@kitschensync.net>

PKG_LICENSE:=LGPLv2 GPLv2
PKG_LICENSE_FILES:=COPYING.LIB COPYING

PKG_BUILD_DIR:=$(BUILD_DIR)/gst-plugins-bad-$(PKG_VERSION)
PKG_SOURCE:=gst-plugins-bad-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://gstreamer.freedesktop.org/src/gst-plugins-bad/
PKG_HASH:=eafbb705190ca6dbf0e5dfbe1bc3d0f217fbc2a828037b5ede12d3611b9f9bd7

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

GST_BAD_LIBS:=
GST_BAD_MODULES:=

define Package/gstreamer1-bad/Default
  CATEGORY:=Multimedia
  SECTION:=multimedia
  TITLE:=GStreamer
  URL:=http://gstreamer.freedesktop.org/
  DEPENDS:= +gst1-plugins-base +libgstreamer1 +libgst1pbutils $(ICONV_DEPENDS) +libusb-1.0 +libgudev
endef

define Package/gstreamer1-bad/description/Default
 GStreamer open source multimedia framework
endef


define Package/gst1-plugins-bad
$(call Package/gstreamer1-bad/Default)
  TITLE+= plugins collection (bad)
  DEPENDS+= $(GST_DEPENDS)
  HIDDEN:=1
endef

define Package/gst1-plugins-bad/description
$(call Package/gstreamer1-bad/description/Default)
 .
 This meta package contains only dependencies to the other plugins from
 the bad plugins collection.
endef

define Package/gstreamer1-plugins-bad
  $(call Package/gstreamer1-bad/Default)
  TITLE+= plugins collection (bad)
  DEPENDS:=+ALL:gst1-plugins-bad +gstreamer1-plugins-base
endef

define Package/gstreamer1-plugins-bad/config
    menu "Select GStreamer bad modules and libraries"
      depends on PACKAGE_gstreamer1-plugins-bad


    config gst1-plugins-bad-all
      bool "Include all GStreamer bad plugins"
      select PACKAGE_gst1-plugins-bad

    comment "Modules"

   $(foreach mod,$(GST_BAD_MODULES), \
    config PACKAGE_gst1-mod-$(mod)
      prompt "GStreamer $(mod) module"

   )

    comment "Libraries"

   $(foreach lib,$(GST_BAD_LIBS), \
    config PACKAGE_libgst1$(lib)
      prompt "GStreamer $(lib) library"

   )

  endmenu

endef

GST_VERSION:=1.0

#CONFIGURE_VARS += \
#	G_UDEV_CFLAGS="-I/tmp/build/openwrt-sdk-brcm2708-bcm2708_gcc-7.3.0_musl_eabi.Linux-x86_64/build_dir/target-arm_arm1176jzf-s+vfp_musl_eabi/libgudev-232/ipkg-install/usr/include/gudev-1.0/" \
#	G_UDEV_LIBS="-L/tmp/build/openwrt-sdk-brcm2708-bcm2708_gcc-7.3.0_musl_eabi.Linux-x86_64/build_dir/target-arm_arm1176jzf-s+vfp_musl_eabi/libgudev-232/ipkg-install/usr/lib -lgudev-1.0" \
	

CONFIGURE_ARGS += \
	--disable-debug \
	--disable-examples \
	--disable-nls	\
	\
	--disable-directsound \
	--disable-directdraw \
	--disable-osx_video \
	--disable-quicktime \
	--disable-vcd \
	--disable-assrender \
	--disable-apexsink \
	--disable-bz2 \
	--disable-dc1394 \
	--disable-directfb \
	--disable-dts \
	--disable-resindvd \
	--disable-faac \
	--disable-faad \
	--disable-flite \
	--disable-gsm \
	--disable-kate \
	--disable-ladspa \
	--disable-lv2 \
	--disable-modplug \
	--disable-mimic \
	--disable-libmms \
	--disable-mpeg2enc \
	--disable-mplex \
	--disable-musepack \
	--disable-mythtv \
	--disable-nas \
	--disable-neon \
	--disable-ofa \
	--disable-rsvg \
	--disable-timidity \
	--disable-wildmidi \
	--disable-sdl \
	--disable-sdltest \
	--disable-sndfile \
	--disable-soundtouch \
	--disable-spc \
	--disable-gme \
	--disable-xvid \
	--disable-dvb \
	--disable-wininet \
	--disable-acm \
	--disable-vdpau \
	--disable-schro \
	--disable-zbar \
	--disable-srtp \
	--disable-fatal-warnings \
	\
	--enable-videoparsers=yes \
	--enable-uvch264=yes \
	\
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--with-libgcrypt-prefix="$(STAGING_DIR)/usr" \
	--without-x \
	

TARGET_CFLAGS+= -std=gnu99

EXTRA_LDFLAGS+= \
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib \
	$(if $(ICONV_FULL),-liconv) \


define Package/gst1-plugins-bad/install
	/bin/true
endef

# 1: short name
# 2: description
# 3: dependencies on other gstreamer libraries (short name)
# 4: dependencies on other packages
define GstBuildLibrary

  GST_DEPENDS += +libgst1$(1)

  GST_BAD_LIBS+= $(1)
  define Package/libgst1$(1)
    $(call Package/gstreamer1-bad/Default)
    TITLE+= $(2) library (base)
    DEPENDS+= $$(foreach p,$(3),+libgst1$$(p)) $(4)
    HIDDEN:=1
  endef

  define Package/libgst1$(1)/description
   $(call Package/gstreamer1-bad/description/Default)
   .
   This package contains the GStreamer $(2) library.
  endef

  define Package/libgst1$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib
	( cd $(PKG_INSTALL_DIR); $(CP) \
		./usr/lib/libgst$(1)-$(GST_VERSION).so.* \
		$$(1)/usr/lib/ \
	)
  endef

  $$(eval $$(call BuildPackage,libgst1$(1)))
endef

$(eval $(call GstBuildLibrary,adaptivedemux,adaptivedemux,app uridownloader,))
$(eval $(call GstBuildLibrary,photography,photography,,))
$(eval $(call GstBuildLibrary,basecamerabinsrc,basecamerabinsrc,app,))
$(eval $(call GstBuildLibrary,uridownloader,uridownloader,,))
#$(eval $(call GstBuildLibrary,badbase,badbase,,))
$(eval $(call GstBuildLibrary,codecparsers,codecparsers,,))

# 1: short name
# 2: description
# 3: dependencies on other gstreamer libraries (short name)
# 4: dependencies on other gstreamer plugins (short name)
# 5: dependencies on other packages
define GstBuildPlugin

  GST_DEPENDS += +gst1-mod-$(1)

  GST_BAD_MODULES+= $(1)

  define Package/gst1-mod-$(1)
    $(call Package/gstreamer1-bad/Default)
    TITLE+= $(2) plugin (bad)
    DEPENDS+= $$(foreach p,$(3),+libgst1$$(p)) $$(foreach p,$(4),+gst1-mod-$$(p)) $(5)
    HIDDEN:=1
  endef

  define Package/gst1-mod-$(1)/description
   $(call Package/gstreamer1-bad/description/Default)
   .
   This package contains the GStreamer $(2) plugin.
  endef

  define Package/gst1-mod-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/gstreamer-$(GST_VERSION)
	( cd $(PKG_INSTALL_DIR); $(CP) \
		./usr/lib/gstreamer-$(GST_VERSION)/libgst$(1).so* \
		$$(1)/usr/lib/gstreamer-$(GST_VERSION)/ \
	)
  endef

  $$(eval $$(call BuildPackage,gst1-mod-$(1)))
endef



define Package/gst1-plugins-bad-rest
  CATEGORY:=Multimedia
  SECTION:=multimedia
  TITLE+= all rest files modules, from gst1-plugins-bad
  URL:=http://gstreamer.freedesktop.org/
  DEPENDS+= $(GST_DEPENDS) +gst1-plugins-base +libgstreamer1 +libgst1pbutils $(ICONV_DEPENDS) +libstdcpp +fdk-aac +libopenssl
endef

define Package/gst1-plugins-bad-rest/description
  This package contains all rest files from gst1-plugins-bad
endef

define Package/gst1-plugins-bad-rest/install
	./install-rest.sh $(TOPDIR) $(PKG_BUILD_DIR) $(PKG_INSTALL_DIR) $(1)
endef



$(eval $(call GstBuildPlugin,adpcmdec,adpcm decoding support,audio,,))
$(eval $(call GstBuildPlugin,adpcmenc,adpcm encoding support,audio,,))
$(eval $(call GstBuildPlugin,aiff,aiff support,audio tag,,))
$(eval $(call GstBuildPlugin,asfmux,asf muxing support,rtp,,))
$(eval $(call GstBuildPlugin,autoconvert,autoconvert support,,,))
$(eval $(call GstBuildPlugin,bayer,bayer support,video,,))
$(eval $(call GstBuildPlugin,camerabin,camerabin support,basecamerabinsrc photography pbutils app,,))
#$(eval $(call GstBuildPlugin,dataurisrc,dataurisrc support,,,))
$(eval $(call GstBuildPlugin,debugutilsbad,debugutils support,video,,))
$(eval $(call GstBuildPlugin,dvdspu,dvdspu support,video,,))
$(eval $(call GstBuildPlugin,fbdevsink,fbdev support,video,,))
$(eval $(call GstBuildPlugin,festival,festival support,audio,,))
$(eval $(call GstBuildPlugin,hls,HLS support,pbutils adaptivedemux,multifile,+libnettle))
$(eval $(call GstBuildPlugin,frei0r,frei0r support,controller video,,))
$(eval $(call GstBuildPlugin,id3tag,id3tag support,tag,,))
$(eval $(call GstBuildPlugin,jpegformat,jpegformat support,tag,,))
$(eval $(call GstBuildPlugin,mpegpsdemux,mpegpsdemux support,pbutils,,))
$(eval $(call GstBuildPlugin,mpegpsmux,mpegpsmux support,,,))
#$(eval $(call GstBuildPlugin,mpegtsdemux,mpegtsdemux support,mpegts pbutils,,))
#$(eval $(call GstBuildPlugin,mpegtsmux,mpegtsmux support,video,,))
$(eval $(call GstBuildPlugin,mxf,mxf support,audio video,,))

$(eval $(call GstBuildPlugin,opusparse,OPUS streams library,pbutils,,+libopus))
$(eval $(call GstBuildPlugin,pcapparse,pcapparse support,,,))
$(eval $(call GstBuildPlugin,pnm,pnm support,video,,))
#$(eval $(call GstBuildPlugin,rawparse,rawparse support,audio video,,))
$(eval $(call GstBuildPlugin,rfbsrc,librfb support,video,,))
$(eval $(call GstBuildPlugin,sdpelem,sdp support,rtp sdp,,))
$(eval $(call GstBuildPlugin,segmentclip,segmentclip support,audio,,))
$(eval $(call GstBuildPlugin,shm,POSIX shared memory source and sink,,,+librt))
$(eval $(call GstBuildPlugin,siren,siren support,audio rtp,,))
$(eval $(call GstBuildPlugin,speed,speed support,audio,,))
$(eval $(call GstBuildPlugin,subenc,subenc support,controller,,))
#$(eval $(call GstBuildPlugin,srtp,srtp support,rtp,,+libsrtp))
$(eval $(call GstBuildPlugin,videoparsersbad,videoparser support,video pbutils codecparsers,,))

$(eval $(call GstBuildPlugin,uvch264,UVC h264 support,basecamerabinsrc,,+libgudev))

$(eval $(call BuildPackage,gstreamer1-plugins-bad))
$(eval $(call BuildPackage,gst1-plugins-bad))

$(eval $(call BuildPackage,gst1-plugins-bad-rest))