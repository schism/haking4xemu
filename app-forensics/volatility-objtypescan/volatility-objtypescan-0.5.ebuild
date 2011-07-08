# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils

MY_P=${P/-/_}
DESCRIPTION="Volatility plugin for enumerating windows kernel object types"
HOMEPAGE="http://computer.forensikblog.de"
SRC_URI="http://computer.forensikblog.de/files/volatility_plugins/${MY_P}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-forensics/volatility-1.3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	mkdir -p ${S}
	cd "${S}"
	unpack ${A}
	cp ${FILESDIR}/setup.py ${S}
}
