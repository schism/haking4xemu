# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library and tools to support the BitLocker Drive Encryption (BDE) encrypted volumes."
HOMEPAGE="http://code.google.com/p/libbde/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos ~x64-macos"
IUSE="debug python nls unicode uuid"

DEPEND="uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	sys-libs/zlib
	dev-libs/openssl
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	dev-libs/libuna
	dev-libs/libbfio
	python? ( dev-lang/python )
	dev-libs/openssl"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=( '--disable-rpath'
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_enable python)
	)
	autotools-utils_src_configure
}
