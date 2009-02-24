# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib distutils

DESCRIPTION="Simple x86 disassembly library"
HOMEPAGE="http://www.nologin.org/main.pl?action=codeView&codeId=49&"
SRC_URI="http://www.klake.org/~jt/misc/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="python? ( virtual/python )"
RDEPEND=${DEPEND}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e "s:CC  *= :CC ?= :
		s:CFLAGS  *= -Wall -O. :CFLAGS += :
		s:PREFIX  *= :PREFIX ?= :
		s: -shared : -shared -Wl,-soname,${PN}.so.1.0 :" Makefile
}

src_compile() {
	emake -j1 || die "compile failed"
	if use python; then
		cd pydasm
		distutils_src_compile
	fi
}

src_install() {
	dolib libdasm.a || die 'install failed'
	dosym libdasm.so libdasm.so.1.0
	dolib.so libdasm.so* || die 'install failed'
	insinto /usr/include
	doins libdasm.h || die 'install failed'
	dobin examples/das
	dodoc HISTORY.txt README.txt
	if use python; then
		cd pydasm
		mv README.txt README-pydasm.txt
		distutils_src_install
	fi
}
