# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
MY_PN=${PN}-alpha
DESCRIPTION="Library for cross-platform formatting of date/time"
HOMEPAGE="http://code.google.com/p/libflibs/"
SRC_URI="http://libflibs.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls"

DEPEND="nls? (
			virtual/libiconv
			virtual/libintl )"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)
}
