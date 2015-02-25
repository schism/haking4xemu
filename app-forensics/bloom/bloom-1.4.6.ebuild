# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools java-utils-2
DESCRIPTION="Bloom file manipulation tools"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x86-macos ~x64-macos"
IUSE="java"

DEPEND="dev-libs/openssl
	app-forensics/afflib
	java? ( >=virtual/jdk-1.5 )"

src_install() {
	default
	if use java; then
		java-pkg_dojar java/frag_find.jar
	fi
	rm ${D}/usr/bin/demo_*
}
