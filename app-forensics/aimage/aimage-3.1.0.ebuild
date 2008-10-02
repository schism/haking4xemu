# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

DESCRIPTION="Tool for creating AFF images"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ewf readline ncurses expat"

DEPEND="ewf? ( app-forensics/libewf )
	readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	expat? ( dev-libs/expat )
	app-forensics/afflib
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND=${DEPEND}

src_compile() {
	econf $(use_with expat)
	emake
}

src_install() {
	emake install DESTDIR="${D}"
}
