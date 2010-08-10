# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit eutils flag-o-matic

MOUNT=mount_ewf-20090529.py

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${P}.tar.gz
	python? ( mirror://sourceforge/libewf/${MOUNT} )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc s390 sparc x86 x64-macos x86-macos"
IUSE="debug python rawio unicode"

DEPEND="|| (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		)
	sys-libs/zlib
	dev-libs/openssl
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

src_configure() {
	append-flags -fno-strict-aliasing # avoid type-punned warnings
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable python) \
		--disable-v2-api
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README documents/*.txt
	if use python; then
		newsbin ${DISTDIR}/${MOUNT} mount_ewf \
			|| die "install mount_ewf failed"
	fi
}
