# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib toolchain-funcs

DESCRIPTION="Cisco-style (telnet) command-line interface library"

HOMEPAGE="http://code.google.com/p/libcli/"
SRC_URI="http://libcli.googlecode.com/files/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	# Support /lib{32,64}
	sed -i 's:$(PREFIX)/lib:$(libdir):g' "${S}"/Makefile
	sed -i 's:PREFIX = /usr/local:&\nlibdir = $(PREFIX)/lib:' "${S}"/Makefile
}

src_compile() {
	emake OPTIM="" DEBUG="" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" \
		PREFIX=/usr \
		OPTIM="" \
		DEBUG="" \
		libdir="/usr/$(get_libdir)" \
		install || die "emake install failed"

	dobin clitest
	dodoc README
}
