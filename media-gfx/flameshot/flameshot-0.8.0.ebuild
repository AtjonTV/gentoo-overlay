# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake cmake-utils xdg-utils git-r3

DESCRIPTION="Powerful yet simple to use screenshot software for LLVM/Linux"
HOMEPAGE="https://flameshot.js.org"
EGIT_REPO_URI="https://github.com/flameshot-org/${PN}.git"
EGIT_COMMIT="v${PV}.rc1"

LICENSE="FreeArt GPL-3+ Apache-2.0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"
IUSE="kde"

DEPEND="
	>=dev-qt/qtsvg-5.3.0:5
	>=dev-qt/qtcore-5.3.0:5
	>=dev-qt/qtdbus-5.3.0:5
	>=dev-qt/qtnetwork-5.3.0:5
	>=dev-qt/qtwidgets-5.3.0:5
	>=dev-qt/linguist-tools-5.3.0:5
"
RDEPEND="${DEPEND}
	kde? (
		kde-plasma/plasma-desktop:5
		kde-frameworks/kglobalaccel:5
	)
"

src_install(){
    cmake-utils_src_install

	if use kde; then
		insinto /usr/share/config
		newins docs/shortcuts-config/${PN}-shortcuts-kde ${PN}rc
	fi

	newinitd "${FILESDIR}/flameshot.initd" flameshot || die
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}
