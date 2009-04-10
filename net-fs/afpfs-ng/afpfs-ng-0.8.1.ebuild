# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="An Apple Filing Protocol client implemented in FUSE"
HOMEPAGE="http://sourceforge.net/projects/afpfs-ng/"
SRC_URI="mirror://sourceforge/afpfs-ng/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libgcrypt
	sys-libs/readline
	dev-libs/gmp
	sys-fs/fuse"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
}
