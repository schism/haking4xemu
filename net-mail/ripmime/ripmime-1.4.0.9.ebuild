# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.4.0.6.ebuild,v 1.5 2006/09/24 10:08:56 blubb Exp $

DESCRIPTION="extract attachment files out of a MIME-encoded email pack"
HOMEPAGE="http://pldaniels.com/ripmime/"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
	emake CFLAGS="${CFLAGS}" libripmime || die
}

src_install() {
	dobin ripmime || die
	doman ripmime.1
	dodoc CHANGELOG INSTALL README TODO
	mkdir -p "${D}"/usr/lib
	mkdir -p "${D}"/usr/include/ripmime
	install mime.h  "${D}"/usr/include/ripmime
	install ripmime-api.h  "${D}"/usr/include/ripmime
	install libripmime.a "${D}"/usr/lib
}
