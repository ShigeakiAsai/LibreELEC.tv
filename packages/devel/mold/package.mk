# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mold"
PKG_VERSION="2.39.1"
PKG_SHA256="231ea3643a14fe5b88478c97b68b31f7c975b57b247a81356ffd889d015b5cc1"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/rui314/mold"
PKG_URL="https://github.com/rui314/mold/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cmake:host zlib:host zstd:host openssl:host tbb:host mimalloc:host"
PKG_LONGDESC="mold is a faster drop-in replacement for existing Unix linkers"

PKG_CMAKE_OPTS_HOST="-DCMAKE_INSTALL_LIBDIR="${TOOLCHAIN}/${TARGET_NAME}/lib"
                     -DCMAKE_INSTALL_BINDIR="${TARGET_NAME}/bin" \
                     -DCMAKE_INSTALL_LIBEXECDIR="${TARGET_NAME}" \
                     -DMOLD_LTO=ON \
                     -DMOLD_MOSTLY_STATIC=ON \
                     -DMOLD_USE_SYSTEM_MIMALLOC=ON \
                     -DMOLD_USE_SYSTEM_TBB=ON"

post_makeinstall_host() {
  ln -sf ${TOOLCHAIN}/${TARGET_NAME}/bin/mold ${TARGET_PREFIX}ld.mold
}
