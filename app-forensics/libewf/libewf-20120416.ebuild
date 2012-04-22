# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}2/${P}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
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
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}
	python? ( dev-python/fuse-python )"

src_configure() {
	append-flags -fno-strict-aliasing # avoid type-punned warnings
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable uuid guid) \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable python) \
		$(use_with fuse libfuse)
}

src_install() {
	default
	dodoc documents/*.txt
}
