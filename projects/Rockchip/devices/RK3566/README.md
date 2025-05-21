# RK3566

This is a work-in-progress SoC device for RK3566

**Known Issues/Limitations**

* uses rkbin ddr init blob instead of u-boot tpl
  - u-boot does not have any ddr init code
* uses rkbin atf blob
  - open source atf has not been tested
* ram is limited to ~4gb with `mem=3838M` (memory range `0x00200000` - `0xefffffff`)
  - there is an issue with importing decoded video frames into display stack
  - old work-in-progress patches broke display stack for older socs
* display stack drivers is missing features for 10-bit and YCbCr output
* hw decoding is limited to vdpu121 (mpeg2, h264 1080p and vp8)
  - there is currently no support for vdpu346 (h264 4k, hevc, vp9) in rkvdec driver

**Build**

* `PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 UBOOT_SYSTEM=orangepi-3b make image`
* `PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 UBOOT_SYSTEM=quartz64-a make image`
* `PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 UBOOT_SYSTEM=quartz64-b make image`
* `PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 UBOOT_SYSTEM=radxa-zero-3 make image`
* `PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 UBOOT_SYSTEM=rock-3c make image`
