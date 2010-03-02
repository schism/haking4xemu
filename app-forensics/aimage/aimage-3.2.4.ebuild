# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool for creating AFF images"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

EAPI="2"
LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos"
IUSE="ewf readline ncurses"

DEPEND="ewf? ( app-forensics/libewf )
	readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	app-forensics/afflib
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND=${DEPEND}

src_install() {
	emake install DESTDIR="${D}"
	dodoc ChangeLog
}
