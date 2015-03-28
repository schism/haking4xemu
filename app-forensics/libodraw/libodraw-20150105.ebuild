# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools-utils 

MY_DATE="$(get_version_component_range 1)"
DESCRIPTION="Library to support optical disc (split) RAW formats"
HOMEPAGE="https://github.com/libyal/libodraw/"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_DATE}/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls unicode"

DEPEND="nls? (
			virtual/libiconv
			virtual/libintl
		)
	dev-libs/libuna
	app-forensics/libbfio"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_enable debug verbose-output)
		$(use_enable debug debug-output)
	)
	autotools-utils_src_configure
}
