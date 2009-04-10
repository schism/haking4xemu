# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools cvs

DESCRIPTION="An Apple Filing Protocol client implemented via FUSE"
HOMEPAGE="http://sourceforge.net/projects/afpfs-ng/"
SRC_URI=""
ECVS_SERVER="${PN}.cvs.sourceforge.net:/cvsroot/${PN}"
ECVS_MODULE="${PN}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="fuse"

S="${WORKDIR}/${ECVS_MODULE}"

DEPEND="dev-libs/libgcrypt
	dev-libs/gmp
	sys-libs/readline
	sys-fs/fuse"

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch ${FILESDIR}/${P}-limits.h.patch
	eautoreconf
}

src_compile() {
	econf  || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc Bugs.txt ChangeLog NEWS docs/README docs/FEATURES.txt
}
