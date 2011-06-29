# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic

MOUNT=mount_ewf-20110626.py

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	python? ( mirror://sourceforge/${PN}/${MOUNT} )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug python rawio unicode uuid"

DEPEND="uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	sys-libs/zlib
	dev-libs/openssl
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}
	python? ( dev-python/fuse-python )"

src_configure() {
	append-flags -fno-strict-aliasing # avoid type-punned warnings
	econf \
		$(use_enable uuid guid) \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable python) \
		--enable-v1-api
}

src_install() {
	default
	dodoc documents/*.txt
	if use python; then
		newsbin ${DISTDIR}/${MOUNT} mount_ewf \
			|| die "install mount_ewf failed"
	fi
}
