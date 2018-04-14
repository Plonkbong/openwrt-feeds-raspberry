# openwrt-feeds-raspberry
some extra packages and updates for openwrt on raspberry-pi-1b



## Build with Openwrt SDK:
=========================
Download and unpack the SDK
	wget -O - https://downloads.openwrt.org/snapshots/targets/brcm2708/bcm2708/openwrt-sdk-brcm2708-bcm2708_gcc-7.3.0_musl_eabi.Linux-x86_64.tar.xz | tar -xJ
	cd ./openwrt-sdk-brcm2708-bcm2708_gcc-7.3.0_musl_eabi.Linux-x86_64
	
add this feed to feeds.conf
	cp ./feeds.conf.default ./feeds.conf
	echo "src-git customrpi https://github.com/Plonkbong/openwrt-feeds-raspberry.git" >> ./feeds.conf
	
It is required to build with BUILD_PATENTED=y for this reason i change it in ./Config.in so i must not change manuell at menuconfig
	sed s/"source .*"/""/g -i ./Config.in
	cat << EOF >> ./Config.in
	config BUILD_PATENTED
		bool
		default y
	
	source "Config-build.in"
	source "tmp/.config-package.in"	
	EOF

update and install the feeds:
	./scripts/feeds update -a
	./scripts/feeds install -p customrpi -a

Compile a single Package in this example v4l2rtspserver
on menuconfig screen keep  settings and store the ./.config only
	make package/v4l2rtspserver/compile V=99
For all kernel libs and utils packages:
	make package/libx264/compile V=99 || read; make package/libgudev/compile V=99 || read; make package/usbtv/compile V=99 || read; make package/v4l2loopback/compile V=99 || read; make package/eudev/compile V=99 || read;
For all gstreamer main packages:
	make package/gst1-libav/compile V=99 || read; make package/gstreamer1/compile V=99 || read; make package/gst1-plugins-base/compile V=99 || read; make package/gst1-plugins-good/compile V=99 || read; make package/gst1-plugins-bad/compile V=99 || read; make package/gst1-plugins-ugly/compile V=99 || read;
For rest multimedia packages:
	make package/ffmpeg/compile V=99 || read; make package/rpiuserland/compile V=99 || read; make package/gst-rpicamsrc/compile V=99 || read; make package/gst1-rtsp-server/compile V=99 || read; make package/v4l2rtspserver/compile V=99 || read; make package/v4l2tools/compile V=99 || read;
