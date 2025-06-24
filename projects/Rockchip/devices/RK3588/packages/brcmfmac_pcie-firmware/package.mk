# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_pcie-firmware"
PKG_VERSION="0.1"
PKG_LICENSE="GPL"
PKG_LONGDESC="Broadcom PCIE firmware used with LibreELEC"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  FW_TARGET_DIR=${INSTALL}/$(get_full_firmware_dir)

  mkdir -p "${FW_TARGET_DIR}/brcm"
    cp -av "${PKG_DIR}/brcm/brcmfmac43752-pcie.bin" "${FW_TARGET_DIR}/brcm"
    cp -av "${PKG_DIR}/brcm/brcmfmac43752-pcie.clm_blob" "${FW_TARGET_DIR}/brcm"
    cp -av "${PKG_DIR}/brcm/brcmfmac43752-pcie.txt" "${FW_TARGET_DIR}/brcm"
    cp -av "${PKG_DIR}/brcm/brcmfmac43752-pcie.armsom,sige7.bin" "${FW_TARGET_DIR}/brcm"
    cp -av "${PKG_DIR}/brcm/brcmfmac43752-pcie.armsom,sige7.txt" "${FW_TARGET_DIR}/brcm"
}
