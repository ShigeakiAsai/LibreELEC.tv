# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxml2"
PKG_VERSION="2.14.4"
PKG_SHA256="8e20c2ef2fc7965d7851e3ab3a756c3fc8b449ba47526269a9b4d7f0480550db"
PKG_LICENSE="MIT"
PKG_SITE="http://xmlsoft.org"
PKG_URL="https://gitlab.gnome.org/GNOME/${PKG_NAME}/-/archive/v${PKG_VERSION}/${PKG_NAME}-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="zlib:host ninja:host Python3:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="The libxml package contains an XML library, which allows you to manipulate XML files."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_ALL="-DBUILD_SHARED_LIBS=ON \
                    -DLIBXML2_WITH_ICONV=OFF \
                    -DLIBXML2_WITH_ICU=OFF \
                    -DLIBXML2_WITH_LZMA=OFF \
                    -DLIBXML2_WITH_TESTS=OFF \
                    -DLIBXML2_WITH_THREADS=ON \
                    -DLIBXML2_WITH_ZLIB=OFF"

PKG_CMAKE_OPTS_HOST="${PKG_CMAKE_OPTS_ALL} \
                     -DLIBXML2_WITH_PYTHON=ON"

PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_ALL} \
                       -DLIBXML2_WITH_PYTHON=OFF"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/xml2-config

  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/lib/xml2Conf.sh
}
