# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod linux-info

DESCRIPTION="Nvidia-based graphics adapter backlight driver for MacBookPro"
HOMEPAGE="https://launchpad.net/~mactel-support"
SRC_URI="https://launchpad.net/~mactel-support/+archive/ppa/+files/${PN}-dkms_${PV}~maverick.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-dkms-${PV}/usr/src/dkms_source_tree"

MODULE_NAMES="mbp_nvidia_bl(kernel/drivers)"

pkg_setup() {
	kernel_is -lt 2 6 29 && die "kernel 2.6.29 or higher is required"
	linux-mod_pkg_setup
	if linux_chkconfig_present BACKLIGHT_MBP_NVIDIA; then
		eerror "You've enabled BACKLIGHT_MBP_NVIDIA."
		eerror "It may collide with this package's module."
		eerror "Please disable it."
		eerror
		eerror "  Device Drivers  --->"
		eerror "    Graphics support  --->"
		eerror "      Backlight & LCD device support  --->"
		eerror "        < > MacBook Pro Nvidia Backlight Driver"
		die "BACKLIGHT_MBP_NVIDIA enabled"
	fi
	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	BUILD_TARGETS="mbp_nvidia_bl.ko"
}
