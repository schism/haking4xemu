# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libewf/libewf-20140427.ebuild,v 1.2 2014/08/08 14:00:42 blueness Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils distutils-r1


DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://code.google.com/p/libewf/"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSMTdoaVExWWNsRjg/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-macos ~x64-macos"
IUSE="debug ewf1 fuse python nls ssl unicode uuid zlib"

DEPEND="
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	dev-libs/libuna
	app-forensics/libbfio
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1
PATCHES=( "${FILESDIR}"/${P}-libbfio_include.patch )

src_configure() {
	local myeconfargs=(
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable ewf1 v1-api)
		$(use_enable python)
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_with zlib)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
		$(use_with fuse libfuse)
	)
	autotools-utils_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use python; then
		cd pyewf
		distutils-r1_src_compile
	fi
}

src_install() {
	autotools-utils_src_install
	if use python; then
		cd pyewf
		distutils-r1_src_install
		cd -
	fi
}
