# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils python

DESCRIPTION="A Python library that will disassemble X86."
HOMEPAGE="http://www.immunitysec.com/resources-freesoftware.shtml"
SRC_URI="${HOMEPAGE}/downloads/${PN}${PV}.tar.gz"

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
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins opcode86.py
	dodoc README
}
