# Changelog

## [23.8.31a18](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.31a18) (2023-08-31)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.31a17...23.8.31a18)

**Merged pull requests:**

- Refactor GUI service [\#62](https://github.com/NeonGeckoCom/neon_debos/pull/62) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.31a17](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.31a17) (2023-08-31)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.31a16...23.8.31a17)

**Merged pull requests:**

- Include hostname changes in update data migration [\#67](https://github.com/NeonGeckoCom/neon_debos/pull/67) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.31a16](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.31a16) (2023-08-31)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.31a15...23.8.31a16)

**Fixed bugs:**

- \[BUG\] Applying an OS update appears to reset the SSH host key [\#59](https://github.com/NeonGeckoCom/neon_debos/issues/59)

**Merged pull requests:**

- Refactor bluetooth script to only restart when config.txt is modified [\#66](https://github.com/NeonGeckoCom/neon_debos/pull/66) ([NeonDaniel](https://github.com/NeonDaniel))
- Refactor `first_run` to separate steps [\#64](https://github.com/NeonGeckoCom/neon_debos/pull/64) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.31a15](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.31a15) (2023-08-31)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.29a14...23.8.31a15)

**Merged pull requests:**

- Update metadata recipe to use only default Python packages [\#65](https://github.com/NeonGeckoCom/neon_debos/pull/65) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.29a14](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.29a14) (2023-08-29)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.25a13...23.8.29a14)

**Implemented enhancements:**

- \[FEAT\] Easy way to determine the exact squashfs build revision [\#58](https://github.com/NeonGeckoCom/neon_debos/issues/58)

**Fixed bugs:**

- \[BUG\] It's easy to introduce \(non-fatal\) data restore errors in `check_update.sh` if new firstboot-type flags are created [\#56](https://github.com/NeonGeckoCom/neon_debos/issues/56)
- \[BUG\] log2ram git clone isn't cleaned up [\#60](https://github.com/NeonGeckoCom/neon_debos/issues/60)

**Merged pull requests:**

- Resolve init errors and clean up build leftovers [\#61](https://github.com/NeonGeckoCom/neon_debos/pull/61) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.25a13](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.25a13) (2023-08-25)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.25a12...23.8.25a13)

**Merged pull requests:**

- Add usbutils to developer extras [\#55](https://github.com/NeonGeckoCom/neon_debos/pull/55) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.25a12](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.25a12) (2023-08-25)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.24a11...23.8.25a12)

**Merged pull requests:**

- Add service to enable Bluetooth in updates [\#53](https://github.com/NeonGeckoCom/neon_debos/pull/53) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.24a11](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.24a11) (2023-08-24)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.24a10...23.8.24a11)

**Merged pull requests:**

- Add reset button check in initramfs in case OS is really broken [\#54](https://github.com/NeonGeckoCom/neon_debos/pull/54) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.24a10](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.24a10) (2023-08-24)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.23a9...23.8.24a10)

**Merged pull requests:**

- Update process improvements [\#52](https://github.com/NeonGeckoCom/neon_debos/pull/52) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.23a9](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.23a9) (2023-08-23)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.23a8...23.8.23a9)

**Merged pull requests:**

- Include image metadata in automation uploads [\#51](https://github.com/NeonGeckoCom/neon_debos/pull/51) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.23a8](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.23a8) (2023-08-23)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.22a7...23.8.23a8)

**Merged pull requests:**

- Copy image metadata to output directory [\#50](https://github.com/NeonGeckoCom/neon_debos/pull/50) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.22a7](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.22a7) (2023-08-22)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.22a6...23.8.22a7)

**Merged pull requests:**

- Reorder recipes for larger base images [\#49](https://github.com/NeonGeckoCom/neon_debos/pull/49) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.22a6](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.22a6) (2023-08-22)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.21a5...23.8.22a6)

**Merged pull requests:**

- Fix system config handling [\#48](https://github.com/NeonGeckoCom/neon_debos/pull/48) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.21a5](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.21a5) (2023-08-21)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.21a4...23.8.21a5)

**Merged pull requests:**

- Cleanup Audio Reciever Package Installation [\#47](https://github.com/NeonGeckoCom/neon_debos/pull/47) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.21a4](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.21a4) (2023-08-21)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.21a3...23.8.21a4)

**Merged pull requests:**

- Staged build recipes with base image [\#45](https://github.com/NeonGeckoCom/neon_debos/pull/45) ([NeonDaniel](https://github.com/NeonDaniel))

## [23.8.21a3](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.21a3) (2023-08-21)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/23.8.16a2...23.8.21a3)

**Implemented enhancements:**

- Media Casting [\#16](https://github.com/NeonGeckoCom/neon_debos/issues/16)

**Merged pull requests:**

- feat: Mark 2 Audio Receiver [\#23](https://github.com/NeonGeckoCom/neon_debos/pull/23) ([mikejgray](https://github.com/mikejgray))

## [23.8.16a2](https://github.com/NeonGeckoCom/neon_debos/tree/23.8.16a2) (2023-08-16)

[Full Changelog](https://github.com/NeonGeckoCom/neon_debos/compare/86eeae542d6ecf5ba625722f09404f11e5a3f303...23.8.16a2)

**Fixed bugs:**

- \[BUG\] Config precedence isn't respected [\#15](https://github.com/NeonGeckoCom/neon_debos/issues/15)

**Closed issues:**

- Investigate squashfs [\#6](https://github.com/NeonGeckoCom/neon_debos/issues/6)

**Merged pull requests:**

- Debos Versioning and Automation [\#43](https://github.com/NeonGeckoCom/neon_debos/pull/43) ([NeonDaniel](https://github.com/NeonDaniel))
- InitramFS Update /var fixes [\#42](https://github.com/NeonGeckoCom/neon_debos/pull/42) ([NeonDaniel](https://github.com/NeonDaniel))
- Updated Media and Core Config Handling [\#41](https://github.com/NeonGeckoCom/neon_debos/pull/41) ([NeonDaniel](https://github.com/NeonDaniel))
- Resolve audio issues after SquashFS updates [\#40](https://github.com/NeonGeckoCom/neon_debos/pull/40) ([NeonDaniel](https://github.com/NeonDaniel))
- SquashFS Update Enhancements [\#38](https://github.com/NeonGeckoCom/neon_debos/pull/38) ([NeonDaniel](https://github.com/NeonDaniel))
- InitramFS improvements [\#37](https://github.com/NeonGeckoCom/neon_debos/pull/37) ([NeonDaniel](https://github.com/NeonDaniel))
- Automated Image Builds [\#36](https://github.com/NeonGeckoCom/neon_debos/pull/36) ([NeonDaniel](https://github.com/NeonDaniel))
- Improved squashFS update process [\#34](https://github.com/NeonGeckoCom/neon_debos/pull/34) ([NeonDaniel](https://github.com/NeonDaniel))
- Add development extra packages and dev flow improvements [\#33](https://github.com/NeonGeckoCom/neon_debos/pull/33) ([NeonDaniel](https://github.com/NeonDaniel))
- Make build-time parameters configurable and align output image partitions [\#32](https://github.com/NeonGeckoCom/neon_debos/pull/32) ([NeonDaniel](https://github.com/NeonDaniel))
- Add initramfs md5 hash to repo and image metadata [\#31](https://github.com/NeonGeckoCom/neon_debos/pull/31) ([NeonDaniel](https://github.com/NeonDaniel))
- Implement log2ram [\#30](https://github.com/NeonGeckoCom/neon_debos/pull/30) ([NeonDaniel](https://github.com/NeonDaniel))
- Update init to exit on error and resolve some init failures [\#29](https://github.com/NeonGeckoCom/neon_debos/pull/29) ([NeonDaniel](https://github.com/NeonDaniel))
- Swapfile and Zram automation [\#28](https://github.com/NeonGeckoCom/neon_debos/pull/28) ([NeonDaniel](https://github.com/NeonDaniel))
- InitramFS Image Updates [\#27](https://github.com/NeonGeckoCom/neon_debos/pull/27) ([NeonDaniel](https://github.com/NeonDaniel))
- Update enhancements [\#25](https://github.com/NeonGeckoCom/neon_debos/pull/25) ([NeonDaniel](https://github.com/NeonDaniel))
- Firmware Partition Update Support [\#24](https://github.com/NeonGeckoCom/neon_debos/pull/24) ([NeonDaniel](https://github.com/NeonDaniel))
- Boot with Initramfs [\#20](https://github.com/NeonGeckoCom/neon_debos/pull/20) ([NeonDaniel](https://github.com/NeonDaniel))
- Update base image to use Python3.10 [\#19](https://github.com/NeonGeckoCom/neon_debos/pull/19) ([NeonDaniel](https://github.com/NeonDaniel))
- Fix swapped mic channels [\#17](https://github.com/NeonGeckoCom/neon_debos/pull/17) ([NeonDaniel](https://github.com/NeonDaniel))
- Add Neon Core image building [\#13](https://github.com/NeonGeckoCom/neon_debos/pull/13) ([NeonDaniel](https://github.com/NeonDaniel))
- Add kernel build script and update Kernel [\#12](https://github.com/NeonGeckoCom/neon_debos/pull/12) ([NeonDaniel](https://github.com/NeonDaniel))
- Default journald to use volatile storage to reduce disk usage [\#11](https://github.com/NeonGeckoCom/neon_debos/pull/11) ([NeonDaniel](https://github.com/NeonDaniel))
- ALSA Audio Rules and SJ201 Refactor [\#10](https://github.com/NeonGeckoCom/neon_debos/pull/10) ([NeonDaniel](https://github.com/NeonDaniel))
- Fix SJ201 VF input channels [\#8](https://github.com/NeonGeckoCom/neon_debos/pull/8) ([NeonDaniel](https://github.com/NeonDaniel))
- Fix poweroff service to enable restarting [\#7](https://github.com/NeonGeckoCom/neon_debos/pull/7) ([NeonDaniel](https://github.com/NeonDaniel))
- Update minimum memory for swapfile creation [\#4](https://github.com/NeonGeckoCom/neon_debos/pull/4) ([NeonDaniel](https://github.com/NeonDaniel))
- Update to Linux Kernel 5.15 [\#3](https://github.com/NeonGeckoCom/neon_debos/pull/3) ([NeonDaniel](https://github.com/NeonDaniel))
- Feat sj201 interface [\#2](https://github.com/NeonGeckoCom/neon_debos/pull/2) ([NeonDaniel](https://github.com/NeonDaniel))
- Initial changes to support Neon on Debian Bookworm [\#1](https://github.com/NeonGeckoCom/neon_debos/pull/1) ([NeonDaniel](https://github.com/NeonDaniel))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
