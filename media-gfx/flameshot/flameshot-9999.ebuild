# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software for LLVM/Linux"
HOMEPAGE="https://flameshot.js.org"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    KEYWORDS=""
    EGIT_REPO_URI="https://github.com/lupoDharkael/${PN}.git"
else
    SRC_URI="https://github.com/lupoDharkael/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="FreeArt GPL-3+ Apache-2.0"
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

src_prepare(){
	sed -i "s|TAG_VERSION = .*|TAG_VERSION = v${PV}|" ${PN}.pro
	sed -i "s#icons#pixmaps#" ${PN}.pro
	sed -i "s#^Icon=.*#Icon=${PN}#" "docs/desktopEntry/package/${PN}.desktop" \
		"snap/gui/${PN}.desktop" \
		"snap/gui/${PN}-init.desktop"
	default_src_prepare
}

src_configure(){
	eqmake5 CONFIG+=packaging
}

src_install(){
	cp "${FILESDIR}/flameshot.desktop" "docs/desktopEntry/package/flameshot.desktop"
	INSTALL_ROOT="${D}" default_src_install
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
