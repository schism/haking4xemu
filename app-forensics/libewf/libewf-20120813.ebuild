# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~s390 ~sparc ~x86 ~x86-macos ~x64-macos"
IUSE="debug fuse python nls rawio unicode uuid"

DEPEND="uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	sys-libs/zlib
	dev-libs/openssl
	fuse? ( sys-fs/fuse )
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	dev-libs/libuna
	app-forensics/libbfio
	python? ( dev-lang/python )
	dev-libs/openssl"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )

src_configure() {
	local myeconfargs=( '--disable-rpath'
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable uuid guid)
		$(use_enable unicode wide-character-type)
		$(use_enable rawio low-level-functions)
		$(use_enable debug verbose-output)
		$(use_enable debug debug-output)
		$(use_enable python)
		$(use_with fuse libfuse)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	doman manuals/*.1 manuals/*.3
}
