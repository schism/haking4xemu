# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/libtableau/libtableau-alpha}
DESCRIPTION="Linux/Unix library to support reading values from the Tableau(TM) forensic bridges"
HOMEPAGE="http://www.sourceforge.net/projects/libtableau"
SRC_URI="mirror://sourceforge/libtableau/${MY_P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls unicode"

DEPEND="nls? ( virtual/libintl )
	sys-apps/sg3_utils"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
}
