# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xz"
PKG_VERSION="5.8.1"
PKG_SHA256="0b54f79df85912504de0b14aec7971e3f964491af1812d83447005807513cd9e"
PKG_LICENSE="GPL"
PKG_SITE="https://tukaani.org/xz/"
PKG_URL="https://github.com/tukaani-project/xz/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host"
PKG_LONGDESC="A free general-purpose data compression software with high compression ratio."
PKG_BUILD_FLAGS="+pic +pic:host"
PKG_TOOLCHAIN="configure"

# never build shared or k0p happens when building
# on fedora due to host selinux/liblzma
PKG_CONFIGURE_OPTS_HOST="--disable-shared --enable-static \
                         --disable-lzmadec \
                         --disable-lzmainfo \
                         --enable-lzma-links \
                         --disable-nls \
                         --disable-scripts \
                         --enable-symbol-versions=no"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-doc \
                           --disable-lzmadec \
                           --disable-lzmainfo \
                           --disable-lzma-links \
                           --disable-scripts \
                           --disable-xz \
                           --disable-xzdec \
                           --enable-symbol-versions=no"
