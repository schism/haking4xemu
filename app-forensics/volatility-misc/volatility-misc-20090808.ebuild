# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils

DESCRIPTION="Miscallaneous Volatility plugins from various authors"
HOMEPAGE="http://www.forensicswiki.org/wiki/List_of_Volatility_Plugins"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=app-forensics/volatility-1.3"
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	cp ${FILESDIR}/setup.py ${S}
}
