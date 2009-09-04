# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="http://www.sourceforge.net/projects/libuna"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
