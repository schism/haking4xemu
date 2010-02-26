# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Library and tools to access the Microsoft Internet Explorer (MSIE) Cache File (index.dat) files"
HOMEPAGE="http://libmsiecf.sourceforge.net/"
SRC_URI="mirror://sourceforge/libmsiecf/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug unicode"

DEPEND="
	dev-libs/libbfio
	dev-libs/libuna"
RDEPEND="${DEPEND}"

src_configure() {
	econf	$(use_enable debug debug-output) \
			$(use_enable debug verbose-output) \
			$(use_enable unicode wide-character-type) \
			|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
