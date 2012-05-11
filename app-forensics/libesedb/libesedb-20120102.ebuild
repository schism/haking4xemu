# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library and tools to access the Extensible Storage Engine (ESE) Database File (EDB) format"
HOMEPAGE="http://www.sourceforge.net/projects/libesedb"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha/${MY_P}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="debug nls unicode"

DEPEND="unicode? (
			virtual/libiconv
			virtual/libintl )
	dev-libs/libuna
	dev-libs/libbfio
	dev-libs/libfguid
	dev-libs/libfdatetime"

src_configure() {
	econf --disable-rpath \
		$(use_enable unicode wide-character-type) \
		$(use_with unicode libiconv-prefix) \
		$(use_with unicode libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
}
