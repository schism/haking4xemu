# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library that provides basic file input/output abstraction"
HOMEPAGE="http://code.google.com/p/libbfio/"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSTERGV3V4bnZ3dlk/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls unicode"

DEPEND="nls? (
			virtual/libiconv
			virtual/libintl )
		dev-libs/libuna"


src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type)
}
