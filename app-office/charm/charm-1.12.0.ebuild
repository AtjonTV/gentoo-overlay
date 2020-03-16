# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="Charm time tracking"
HOMEPAGE="https://github.com/KDAB/Charm"
SRC_URI="https://github.com/KDAB/Charm/tarball/$PV -> $P.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="debug idledetection timesheettools"

DEPEND=">=dev-qt/qtcore-5.10.0
	>=dev-qt/qtgui-5.10.0
	>=dev-qt/qtsql-5.10.0
	idledetection? ( x11-libs/libXScrnSaver )
	timesheettools? ( dev-db/mysql dev-db/mysql-connector-c++ )
"

src_unpack() {
	# Damn Github
	unpack ${A}
	mv *-Charm-* "${S}"
}

src_configure() {
	MYCMAKEARGS=(
		-DCharm_VERSION="${PV}"
		-DCHARM_TIMESHEET_TOOLS="$(usex timesheettools)"
		-DCHARM_IDLE_DETECTION="$(usex idledetection)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc ReadMe.md
}
