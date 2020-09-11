# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

EGIT_REPO_URI="https://github.com/domschrei/krunner-symbols"
EGIT_COMMIT="${PV}"

DESCRIPTION="A lightweight KRunner plugin (Plasma 5) to retrieve unicode symbols, or any other string, based on a corresponding keyword."
HOMEPAGE="https://github.com/domschrei/krunner-symbols"
SRC_URI=""

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/krunner"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	mkdir build
	cd build

    # Get correct installation directories
    prefix=$(kf5-config --prefix)
    loc_plugin=$(kf5-config --qt-plugins|sed 's.^'"$prefix"'/..')
    loc_desktop=$(kf5-config --path services|awk -F ':' '{print $NF}'|sed 's.^'"$prefix"'/..')
    loc_config=share/config

	cmake -G "Unix Makefiles" .. -DCMAKE_INSTALL_PREFIX=$prefix \
        -DLOCATION_PLUGIN=$loc_plugin \
        -DLOCATION_DESKTOP=$loc_desktop \
        -DLOCATION_CONFIG=$loc_config \
        -DCMAKE_BUILD_TYPE=Release

	emake
}

src_install() {
	INSTALL_DIR="$ED$(kf5-config --qt-plugins)"
	mkdir -p "$INSTALL_DIR"
	cp "$S/build/krunner_symbols.so" "$INSTALL_DIR"
	mkdir -p "$ED/usr/share/config/"
	cp "$S/krunner-symbolsrc" "$ED/usr/share/config/krunner-symbolsrc"
}
