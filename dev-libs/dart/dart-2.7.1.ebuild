# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Dart Programming Language"
HOMEPAGE="https://dart.dev/"

KEYWORDS="amd64"

SRC_URI="https://storage.googleapis.com/dart-archive/channels/stable/release/${PV}/sdk/dartsdk-linux-x64-release.zip"

SLOT="0"
LICENSE="MIT"
IUSE=""

RDEPEND=""
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
        exeinto /usr/bin
        exeopts -m0755
        doexe "${S}"/dart-sdk/bin/dart
        doexe "${S}"/dart-sdk/bin/dart2js
        doexe "${S}"/dart-sdk/bin/dart2native
	doexe "${S}"/dart-sdk/bin/dartanalyzer
	doexe "${S}"/dart-sdk/bin/dartaotruntime
	doexe "${S}"/dart-sdk/bin/dartdevc
	doexe "${S}"/dart-sdk/bin/dartdoc
	doexe "${S}"/dart-sdk/bin/dartfmt
	doexe "${S}"/dart-sdk/bin/pub

	mkdir -p opt/dart
	mv dart-sdk "opt/dart/${PV}"

        insinto /opt/dart/
        doins -r "${S}"/opt/dart/"${PV}"
}


