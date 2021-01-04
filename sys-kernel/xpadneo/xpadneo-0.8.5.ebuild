# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-mod git-r3

DESCRIPTION="Advanced Linux Driver for Xbox One Wireless Gamepad"
HOMEPAGE="https://github.com/atar-axis/xpadneo"
EGIT_REPO_URI="https://github.com/atar-axis/${PN}.git"
EGIT_COMMIT="v${PV}"

SLOT="0"
LICENSE="GPL-3+"
KEYWORDS="amd64"

DEPEND="
	virtual/linux-sources
	sys-kernel/linux-headers
"

S="${S}/hid-xpadneo"

MODULE_NAMES="hid-xpadneo(kernel/drivers/hid)"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="modules"
	BUILD_PARAMS="KVERSION=${KV_FULL}"
}

src_install() {
	insinto /etc/modprobe.d
	newins "${S}"/etc-modprobe.d/xpadneo.conf xpadneo.conf

	mv "${S}/src/hid-xpadneo.ko" "${S}/hid-xpadneo.ko"
	linux-mod_src_install
}
