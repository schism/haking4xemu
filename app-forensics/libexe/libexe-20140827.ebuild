# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit versionator autotools-utils distutils-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library and tooling to access the executable (EXE) format"
HOMEPAGE="https://code.google.com/p/libexe"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSd1dKQVU0WGVESlU/${PN}-experimental-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="debug python unicode"

DEPEND="python? ( dev-lang/python )
		dev-libs/libuna
		app-forensics/libbfio"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		$(use_enable unicode wide-character-type)
		$(use_enable python)
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
	)
	autotools-utils_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use python; then
		cd pyexe
		distutils-r1_src_compile
	fi
}

src_install() {
	autotools-utils_src_install
	if use python; then
		cd pyexe
		distutils-r1_src_install
	fi
}
