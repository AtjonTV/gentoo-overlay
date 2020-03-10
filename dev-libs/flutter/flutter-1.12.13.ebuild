# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Flutter Framework for the Dart Programming Language"
HOMEPAGE="https://flutter.dev/"

KEYWORDS="amd64"

HOTFIX="8"
#SRC_URI="https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v${PV}+hotfix.${HOTFIX}-stable.tar.xz"
EGIT_REPO_URI="https://github.com/flutter/flutter.git"
EGIT_REPO_BRANCH="v${PV}+hotfix.${HOTFIX}"

SLOT="0"
LICENSE="MIT"
IUSE=""

RDEPEND="
	app-shells/bash
	net-misc/curl
	>=dev-vcs/git-2.0.0
	app-arch/zip
	app-arch/unzip
	app-arch/xz-utils
	>=media-libs/glu-9.0.0
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
        exeinto /usr/bin
        exeopts -m0755
        doexe "${S}"/flutter-"${PV}"/bin/flutter

	mkdir -p opt/flutter
        mv flutter-"${PV}" "opt/flutter/${PV}"

        insinto /opt/flutter
        doins -r "${S}"/opt/flutter/"${PV}"
}
