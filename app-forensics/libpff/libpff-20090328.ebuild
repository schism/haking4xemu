# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/libpff/libpff-alpha}
DESCRIPTION="Library and tools to access the PFF (Personal Folder File) format, used in PST and OST"
HOMEPAGE="http://www.sourceforge.net/projects/libpff"
SRC_URI="mirror://sourceforge/libpff/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug unicode"

DEPEND="dev-libs/libuna"
RDEPEND=${DEPEND}

src_compile() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog
}
