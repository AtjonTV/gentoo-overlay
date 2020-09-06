# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs git-r3

DESCRIPTION="Key-value embedded data storage, fork of LMDB"
HOMEPAGE="https://github.com/erthink/libmdbx"
SRC_URI=""

EGIT_REPO_URI="https://github.com/erthink/libmdbx.git"
EGIT_COMMIT="8f5ae79b51b5785f745183afbf5a2cae856940f0"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

if [[ "${PV}" = 9999* ]]; then
	EGIT_BRANCH="master"
fi

DEPEND=""
RDEPEND=""
#RDEPEND="!dev-db/lmdb"

#S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	CFLAGS="$CFLAGS -fPIC"
	sed -i -e "s/^CC.*/CC = $(tc-getCC)/" \
		-e "s/^CFLAGS.*/CFLAGS = ${CFLAGS}/" \
		-e "s/ar rs/$(tc-getAR) rs/" \
		-e "s:^prefix.*:prefix = /usr:" \
		-e "s:/man/:/share/man/:" \
		-e "/for f/s:lib:$(get_libdir):" \
		-e "s:shared:shared -Wl,-soname,libmdbx.so.0:" \
		"${S}/Makefile" || die
	default
}

src_configure() {
	:
}

src_compile() {
	emake CFLAGS+=" -pthread"
}

src_install() {
	echo "${D}"
	if [ "${D}" = "" ]; then
		exit 1
	fi
	mkdir -p "${D}"/usr/{bin,$(get_libdir),include,share/man/man1}
	default

	mv "${D}"/usr/$(get_libdir)/libmdbx.so{,.0} || die
	dosym libmdbx.so.0 /usr/$(get_libdir)/libmdbx.so

	use static-libs || rm -f "${D}"/usr/$(get_libdir)/libmdbx.a
}
