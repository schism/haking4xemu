# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/libtableau/libtableau-alpha}
DESCRIPTION="Linux/Unix library to support reading values from the Tableau(TM) forensic bridges"
HOMEPAGE="http://www.sourceforge.net/projects/libtableau"
SRC_URI="mirror://sourceforge/libtableau/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug unicode"

DEPEND="sys-apps/sg3_utils"
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
	dodoc AUTHORS ChangeLog README
}
