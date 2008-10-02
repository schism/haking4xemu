# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libxcrypt/libxcrypt-2.0.ebuild,v 1.5 2004/10/20 21:12:16 kugelfang Exp $

inherit autotools multilib toolchain-funcs

DESCRIPTION="Libxcrypt is a replacement for libcrypt, which comes with the GNU C \
Library. It supports DES crypt, MD5, and passwords with blowfish encryption."

SRC_URI="http://ftp.suse.com/pub/people/kukuk/libxcrypt/${P}.tar.bz2"
HOMEPAGE="http://www.suse.de/us/private/products/suse_linux/i386/packages_personal/libxcrypt.html"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

src_unpack() {
	unpack "${A}"
	cd "${S}"
	if [ $(gcc-major-version) -eq 3 ] ; then
		epatch ${FILESDIR}/${P}-gcc3-Wshadow.patch
		eautoreconf
	fi
}

src_compile() {
	econf --libdir=/$(get_libdir) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	local libdir=$(get_libdir)
	dodir /usr/${libdir}
	mv ${D}/${libdir}/libxcrypt.{,l}a ${D}/usr/${libdir}
	gen_usr_ldscript libxcrypt.so
	dodoc README* ChangeLog NEWS
}
