# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="https://code.google.com/p/libuna/"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSaXBjN1ZJVzVsbjQ/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls unicode"
DEPEND="nls? (
			virtual/libintl
			virtual/libiconv )"
		#dev-libs/libcerror
		#dev-libs/libcfile
		#dev-libs/libcdatetime
		#dev-libs/libclocale
		#dev-libs/libcnotify"

src_prepare() {
	epatch ${FILESDIR}/${P}-stdio.h.patch
}

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with unicode libiconv-prefix) \
		$(use_with unicode libintl-prefix) \
		$(use_enable unicode wide-character-type)
}

src_install() {
	default
	find ${D} -type f -name libuna.pc -delete
}
