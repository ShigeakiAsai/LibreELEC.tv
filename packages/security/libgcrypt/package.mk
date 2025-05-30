# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgcrypt"
PKG_VERSION="1.11.1"
PKG_SHA256="24e91c9123a46c54e8371f3a3a2502f1198f2893fbfbf59af95bc1c21499b00e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libgcrypt/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="autotools:host gcc:host libgpg-error"
PKG_LONGDESC="A General purpose cryptographic library."
PKG_TOOLCHAIN="autotools"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=${HOST_CC} \
                             ac_cv_sys_symbol_underscore=no \
                             --enable-asm \
                             --with-gnu-ld \
                             --with-libgpg-error-prefix=${SYSROOT_PREFIX}/usr \
                             --disable-doc"
}

post_makeinstall_target() {
  sed -e "s:\(['= ]\)\"/usr:\\1\"${SYSROOT_PREFIX}/usr:g" -i src/${PKG_NAME}-config
  cp src/${PKG_NAME}-config ${SYSROOT_PREFIX}/usr/bin

  rm -rf ${INSTALL}/usr/bin
}
