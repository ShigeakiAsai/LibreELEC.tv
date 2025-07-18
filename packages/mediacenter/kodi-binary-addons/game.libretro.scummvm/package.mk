# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="game.libretro.scummvm"
PKG_VERSION="2.10.0.47-Omega"
PKG_SHA256="3a9e0e49d70cd81600be4ee254b992190d73969b02ca8c36ea1f44161c4c5d53"
PKG_REV="3"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.scummvm"
PKG_URL="https://github.com/kodi-game/game.libretro.scummvm/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-scummvm"
PKG_SECTION=""
PKG_LONGDESC="game.libretro.scummvm: scummvm for Kodi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

pre_configure_target() {
  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||")
}
