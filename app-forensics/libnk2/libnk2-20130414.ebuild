# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools-utils

AUTOTOOLS_IN_SOURCE_BUILD=1
MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library and tooling to support the Microsoft Outlook Nickfile (NK2) format"
HOMEPAGE="http://code.google.com/p/libnk2/"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSZFNVS2JjWkNnelk/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="debug nls unicode"

DEPEND="nls? ( virtual/libintl )
	dev-libs/libuna
	app-forensics/libbfio"

PATCHES=( "${FILESDIR}/${P}-libbfio_include.patch" )

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_enable unicode wide-character-type)
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
	)
	autotools-utils_src_configure
}
