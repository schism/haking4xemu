# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="file integrity verification program"
HOMEPAGE="http://integrit.sourceforge.net/"
SRC_URI="mirror://sourceforge/integrit/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf
	for target in ./ utils/ doc/ ; do
		emake -C $target
	done
	emake -C hashtbl/ hashtest
}

src_install() {
	# 'make install' has a sandbox violation.
	dolib libintegrit.a
	dosbin integrit
	dobin utils/i-ls
	dosbin utils/i-viewdb

	dolib hashtbl/libhashtbl.a
	dobin hashtbl/hashtest
	insinto /usr/include
	doins hashtbl/hashtbl.h
	newdoc hashtbl/README README.hashtbl

	dodoc ChangeLog Changes HACKING todo.txt README
	docinto examples
	dodoc examples/*
	doinfo doc/*.info
	doman doc/*.1
}

pkg_postinst() {
	elog "It is recommended that the integrit binary is copied to a secure"
	elog "location and re-copied at runtime or run from a secure medium."
	elog "You should also create a configuration file (see examples)."
}
