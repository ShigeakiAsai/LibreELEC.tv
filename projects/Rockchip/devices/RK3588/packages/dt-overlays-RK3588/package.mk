# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dt-overlays-RK3588"
PKG_VERSION="1.0"
PKG_DEPENDS_TARGET="dtc:host"
PKG_LONGDESC="The Device Tree Overlays for RK3588"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  for dts in ${PKG_BUILD}/*.dts; do
    $(kernel_path)/scripts/dtc/dtc -@ -I dts -O dtb -o ${dts%.dts}.dtbo ${dts}
  done
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/overlays
    cp -pv ${PKG_BUILD}/*.dtbo ${INSTALL}/usr/share/bootloader/overlays
}
