# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Several libraries for cross-platform C functions"
HOMEPAGE="https://code.google.com/p/libclibs/"
SRC_URI="http://libclibs.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls unicode"

DEPEND="nls? (
		virtual/libiconv
		virtual/libintl )"

src_configure() {
	econf --disable-rpath \
			$(use_enable nls) \
			$(use_enable unicode wide-character-type) \
			$(use_with nls libiconv-prefix) \
			$(use_with nls libintl-prefix)

}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
