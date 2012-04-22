# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library that provides basic file input/output abstraction"
HOMEPAGE="http://www.sourceforge.net/projects/libbfio"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls unicode"

DEPEND="nls? (
			virtual/libiconv
			virtual/libintl )
	dev-libs/libuna"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type)
}
