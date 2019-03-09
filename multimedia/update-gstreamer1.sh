#!/bin/sh

VERSION=1.15.2

DIR_LIST="gst1-libav gst1-plugins-bad gst1-plugins-base gst1-plugins-good gst1-plugins-ugly gst1-rtsp-server gstreamer1"

for DIR in $DIR_LIST; do
	NAME_IN_URL=$(echo "$DIR" | sed s/"[[:digit:]]*"/""/g)
	SHA256=$(wget -q -O - "https://gstreamer.freedesktop.org/src/$NAME_IN_URL/$NAME_IN_URL-$VERSION.tar.xz.sha256sum" | cut -d' ' -f1)
	sed s/"^PKG_VERSION:=.*"/"PKG_VERSION:=$VERSION"/g -i $DIR/Makefile
	sed s/"^PKG_HASH:=.*"/"PKG_HASH:=$SHA256"/g -i $DIR/Makefile
done

exit 0