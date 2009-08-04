# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

DESCRIPTION="Bloom file manipulation tools"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-libs/openssl"
RDEPEND=${DEPEND}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog
	rm ${D}/usr/bin/demo_*
}
