# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library to support the storage media (SM) (split) RAW format"
HOMEPAGE="https://code.google.com/p/libsmlibs/"
SRC_URI="https://libsmlibs.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="debug nls unicode"

DEPEND="nls? (
			virtual/libintl
			virtual/libiconv
		)
	sys-fs/fuse
	dev-libs/libuna
	app-forensics/libbfio"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=( '--disable-rpath'
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_enable debug verbose-output)
		$(use_enable debug debug-output)
	)
	autotools-utils_src_configure
}
