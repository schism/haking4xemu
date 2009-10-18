# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit eutils

MY_P=${P/${PN}/${PN}-beta}
MOUNT=mount_ewf-20090529.py

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${MY_P}-1.tar.gz
	python? ( mirror://sourceforge/libewf/${MOUNT} )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug python rawio unicode v2-api"

DEPEND="|| (	
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
		)
	sys-libs/zlib
	dev-libs/openssl
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable v2-api) \
		$(use_enable python)
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README documents/*.txt
	use python && newsbin ${DISTDIR}/${MOUNT} mount_ewf
}
