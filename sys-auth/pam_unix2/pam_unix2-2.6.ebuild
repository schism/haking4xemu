# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A PAM module that supports NIS+, HP-UX password aging, and password
encryption with DES, bigcrypt, MD5, SHA, and blowfish."

HOMEPAGE="http://www.thkukuk.de/pam/pam_unix2/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/pam/pam_unix2/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND="sys-libs/pam
	>=sys-libs/libxcrypt-3.0"
RDEPEND=${DEPEND}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/pam_prompt-gentoo.patch"
}

src_compile() {
	econf \
		$(use_enable nls) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README NEWS
}
