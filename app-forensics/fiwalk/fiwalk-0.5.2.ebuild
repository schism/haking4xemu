# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils java-utils-2

DESCRIPTION="File carver with plugin validators"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE='java'

DEPEND="dev-libs/openssl
	java? ( >=virtual/jdk-1.5 )"
RDEPEND=${DEPEND}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use java && emake -C plugins plugins.jar \
		|| die "compiling java plugins failed"
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog README TODO fiwalk_all.py
	use java && java-pkg_dojar plugins/plugins.jar
}
