# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit base eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="http://www.radare.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ewf gui lua readline"

RDEPEND="
	dev-lang/python
	dev-lang/perl
	gui? (
		x11-libs/gtk+:2
		x11-libs/vte:0 )
	lua? ( dev-lang/lua )
	ewf? ( app-forensics/libewf )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	gui? ( >=dev-lang/vala-0.5:0.10 )"

src_prepare() {
	base_src_prepare
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-more-ldflags.patch
	# fix documentation installation
	sed -i "s:doc/${PN}:doc/${PF}:g" \
		Makefile.acr global.h.acr src/Makefile.acr wscript dist/maemo/Makefile
}

src_configure() {
	VALAC=$(type -P valac-0.10) econf \
		$(use_with readline) \
		$(use_with ewf) \
		$(use_with gui)
}
