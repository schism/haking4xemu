# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

MY_P=${P#volatility-plugin-}
DESCRIPTION="Volatility plugin for accessing registry data"
HOMEPAGE="http://www.cc.gatech.edu/~brendan/volatility/"
SRC_URI="http://www.cc.gatech.edu/~brendan/volatility/dl/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-forensics/volatility-1.3"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir ${P}
	cd "${S}"
	unpack ${A}
	cp ${FILESDIR}/setup.py ${S}
}
