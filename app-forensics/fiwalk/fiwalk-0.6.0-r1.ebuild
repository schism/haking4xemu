# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit eutils java-utils-2

DESCRIPTION="File carver with plugin validators"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x86-macos ~x64-macos"
IUSE='java'

DEPEND="dev-libs/openssl
	>=app-forensics/sleuthkit-3.0
	java? ( >=virtual/jdk-1.5 )"
RDEPEND=${DEPEND}

src_compile() {
	default
	if use java; then
		emake -C plugins plugins.jar || die "compiling java plugins failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	rm ${D}/usr/bin/test_arff
	dodoc ChangeLog README TODO plugins/*.py
	if use java; then
		java-pkg_dojar plugins/plugins.jar || die "installing java plugins failed"
	fi
}
