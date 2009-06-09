# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit autotools

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library that provides basic file input/output abstraction"
HOMEPAGE="http://www.sourceforge.net/projects/libbfio"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="unicode"

DEPEND="dev-libs/libuna"

src_configure() {
	econf $(use_enable unicode wide-character-type)
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
