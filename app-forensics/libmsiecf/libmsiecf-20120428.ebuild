# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Library and tools to access the Microsoft Internet Explorer (MSIE) Cache File (index.dat) files"
HOMEPAGE="http://libmsiecf.sourceforge.net/"
SRC_URI="mirror://sourceforge/libmsiecf/${PN}-alpha/${PN}-alpha-${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="debug nls unicode"

DEPEND="nls? ( virtual/libintl )
	app-forensics/libbfio
	dev-libs/libuna"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable unicode wide-character-type)
}
