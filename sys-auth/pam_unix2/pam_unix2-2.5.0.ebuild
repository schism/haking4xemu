# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools pam

DESCRIPTION="A PAM module that supports NIS+, HP-UX password aging, and password
encryption with DES, bigcrypt, MD5, or blowfish."

HOMEPAGE="http://www.thkukuk.de/pam/pam_unix2/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/pam/pam_unix2/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls"

DEPEND="sys-libs/pam
	>=sys-libs/libxcrypt-2.0"
RDEPEND="sys-libs/pam
	>=sys-libs/libxcrypt-2.0"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/pam_prompt-gentoo.patch"

	AT_M4DIR="m4" eautoreconf

	elibtoolize
}

src_compile() {
	econf \
		--libdir=/$(get_libdir) \
		$(use_enable nls) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dopammod src/pam_unix2.so
	dodoc ChangeLog README NEWS
}

