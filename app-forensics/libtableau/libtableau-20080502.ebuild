# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools-utils

AUTOTOOLS_IN_SOURCE_BUILD=1
MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Linux/Unix library to support reading values from the Tableau(TM) forensic bridges"
HOMEPAGE="http://www.sourceforge.net/projects/libtableau"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiScXhxZnpVTFpkX0E/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls unicode"

DEPEND="nls? ( virtual/libintl )
	sys-apps/sg3_utils"

src_configure() {
	local myeconfargs=(
		$(use_enable nls) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
	)
	autotools-utils_src_configure
}
