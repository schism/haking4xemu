# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

DESCRIPTION="A collection of scripts built for reading Windows® NT/2K/XP/2K3 event log files"
HOMEPAGE="http://projects.sentinelchicken.org/grokevt/"
SRC_URI="http://projects.sentinelchicken.org/data/downloads/${P}.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND} app-forensics/reglookup"

src_unpack() {
	unpack "${A}"
	cd "${S}/lib"
	echo "PATH_CONFIG='/etc/grokevt'" >> grokevt.py
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin bin/grokevt*
	doman doc/man/man1/* doc/man/man7/*
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	doins lib/grokevt.py
	mkdir -p ${D}/etc/grokevt/systems/
	cp -Rf etc/systems/example ${D}/etc/grokevt/systems/
}
