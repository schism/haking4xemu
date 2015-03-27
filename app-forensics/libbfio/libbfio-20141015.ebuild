# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator autotools-utils

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library that provides basic file input/output abstraction"
HOMEPAGE="https://github.com/libyal/libbfio/"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls threads unicode"
DEPEND="nls? (
			virtual/libintl
			virtual/libiconv )
		dev-libs/libuna"

AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

src_configure() {
	local myeconfargs=( '--disable-rpath'
		$(use_enable nls)
		$(use_enable unicode wide-character-type)
		$(use_enable threads multi-threading-support)
	)
	autotools-utils_src_configure
}
