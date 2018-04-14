#!/bin/sh

TOPDIR="$1"
PKG_BUILD_DIR="$2"
PKG_INSTALL_DIR="$3"
PKG_DIR="$4"

#echo "$TOPDIR : $PKG_BUILD_DIR"
#echo "PKG_INSTALL_DIR = $PKG_INSTALL_DIR"
#echo "PKG_DIR = $PKG_DIR"

pkg_arch=$(cat "$TOPDIR/.config" | grep "CONFIG_TARGET_ARCH_PACKAGES" | cut -d= -f2 | tr -d \")
echo "$pkg_arch"

cd "$PKG_BUILD_DIR/ipkg-$pkg_arch"
filelist="$(find . -type f | grep -v CONTROL | cut -d/ -f3-)"

#echo "$filelist"
#read

cp -a "$PKG_INSTALL_DIR"/* "$PKG_DIR"
#mkdir -p "$PKG_BUILD_DIR/ipkg-rest"

for f in $filelist ; do
	rm -v "$PKG_DIR/$f"
done

#read