# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit eutils autotools

MY_P=${P/libewf/libewf-beta}
MOUNT=mount_ewf-20090113.py

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${MY_P}.tar.gz
	python? ( mirror://sourceforge/libewf/${MOUNT} )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="debug python rawio unicode v2-api"

DEPEND="sys-libs/e2fsprogs-libs
	sys-libs/zlib
	dev-libs/openssl
	unicode? ( dev-libs/libuna )
	python? ( dev-lang/python )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use python && use v2-api;then
		eerror "The python and v2-api are currently mutually exclusive"
		eerror "Please select one or the other"
		die "Invalid USE combination"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${P}-*
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable v2-api) \
		$(use_enable python)
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README documents/*.txt
	use python && newsbin ${DISTDIR}/${MOUNT} mount_ewf
}