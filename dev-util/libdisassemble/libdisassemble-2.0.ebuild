# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"

inherit distutils python

DESCRIPTION="A Python library that will disassemble X86."
HOMEPAGE="http://www.immunitysec.com/resources-freesoftware.shtml"
SRC_URI="http://www.immunitysec.com/downloads/${PN}${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}"
}

src_install() {
	exeinto /usr/bin
	newexe disassemble.py disassemble
	insinto $(python_get_sitedir)
	doins opcode86.py
	dodoc README
}
