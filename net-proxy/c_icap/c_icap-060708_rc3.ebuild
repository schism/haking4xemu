# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${P/_rc/rc}
DESCRIPTION="An ICAP server"
HOMEPAGE="http://www.sourceforge.net/projects/c-icap"
SRC_URI="mirror://sourceforge/c-icap/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="clamav ipv6 perl"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --enable-largefile \
		$(use_with clamav) \
		$(use_enable ipv6) \
		$(use_with perl)
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc README INSTALL.txt
}
