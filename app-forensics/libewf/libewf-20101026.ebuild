# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic

MOUNT=mount_ewf-20090529.py

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${PN}-alpha-${PV}.tar.gz
	python? ( mirror://sourceforge/libewf/${MOUNT} )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug python rawio unicode +v1-api"

DEPEND="|| (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		)
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )
	sys-libs/zlib
	dev-libs/openssl"

src_configure() {
	append-flags -fno-strict-aliasing # avoid type-punned warnings
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable v1-api) \
		$(use_enable python)
}

src_install() {
	default
	dodoc documents/*.txt
	if use python; then
		newsbin ${DISTDIR}/${MOUNT} mount_ewf \
			|| die "install mount_ewf failed"
	fi
}

pkg_postinst() {
	if use v1-api;then
		ewarn "You have installed a v2-api version of libewf with v1-api"
		ewarn "compatibility enabled.  Most applications using libewf are"
		ewarn "still broken in this mode.  Use libewf-20100226 if any EWF"
		ewarn "applications other than libewf are important"
	fi
}
