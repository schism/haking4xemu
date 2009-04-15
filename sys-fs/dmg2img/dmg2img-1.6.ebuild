# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dmg2img/dmg2img-1.3.ebuild,v 1.1 2008/11/29 16:01:16 josejx Exp $

EAPI=2

DESCRIPTION="Converts Apple DMG files to standard HFS+ images"
HOMEPAGE="http://vu1tur.eu.org/tools"
SRC_URI="http://vu1tur.eu.org/tools/download.pl?${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND=${DEPEND}

src_install() {
	# Install the Program
	exeinto /usr/sbin
	doexe dmg2img
	doexe vfdecrypt
	# Install the Readme
	dodoc README
	doman vfdecrypt.1
}
