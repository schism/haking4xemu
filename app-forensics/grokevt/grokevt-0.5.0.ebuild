# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils python

DESCRIPTION="A collection of scripts built for reading Windows® NT/2K/XP/2K3 event log files"
HOMEPAGE="http://projects.sentinelchicken.org/grokevt/"
SRC_URI="http://projects.sentinelchicken.org/data/downloads/${P}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/python
	app-forensics/reglookup"

src_prepare() {
	ln -s grokevt-distutils.py setup.py
	sed -i -e 's/\(if .*grokevt-distutils.py install;\)/#\1/' Makefile
}

src_compile() {
	emake ETC_PREFIX="${EPREFIX}/etc"
}

src_install() {
	emake PREFIX="${ED}/usr" \
		ETC_PREFIX="${ED}/etc" \
		DOC_PREFIX="${ED}/usr/share/doc/${P}" \
		MAN_PREFIX="${ED}/usr/share/man" install
	distutils_src_install
}
