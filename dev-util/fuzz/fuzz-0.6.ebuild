# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Fuzz is a tool for testing other software. It does this by bombarding the program being evaluated with random data."
HOMEPAGE="http://fuzz.sourceforge.net"
SRC_URI="mirror://slashdot/fuzz/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="sys-libs/readline"
RDEPEND="sys-libs/readline"

src_install() {
	dobin fuzz
	dodoc README AUTHORS
}
