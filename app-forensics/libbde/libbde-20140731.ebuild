# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit versionator autotools-utils distutils-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library and tools to support the BitLocker Drive Encryption (BDE) encrypted volumes."
HOMEPAGE="http://code.google.com/p/libbde/"
SRC_URI="http://googledrive.com/host/0B3fBvzttpiiSX2VCRk16TnpDd0U/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos ~x64-macos"
IUSE="debug python nls unicode"

DEPEND="
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	python? ( dev-lang/python )
	sys-fs/fuse
	dev-libs/libuna
	app-forensics/libbfio
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=( '--disable-rpath'
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable python)
	)
	autotools-utils_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use python; then
		cd pybde
		distutils-r1_src_compile
	fi
}

src_install() {
	autotools-utils_src_install
	if use python; then
		cd pybde
		distutils-r1_src_install
	fi
}
