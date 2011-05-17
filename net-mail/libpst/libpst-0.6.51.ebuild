# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
HOMEPAGE="http://www.five-ten-sg.com/libpst/"
SRC_URI="http://www.five-ten-sg.com/${PN}/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc64 ~x86 ~x64-macos ~x86-macos"
IUSE="debug dii python"

RDEPEND="dii? ( media-gfx/imagemagick[png] )"
DEPEND="virtual/libiconv
	dii? ( media-libs/gd[png] )
	python? ( >=dev-libs/boost-1.35.0-r5[python] )
	${RDEPEND}"

src_configure() {
	econf \
		$(use_enable debug pst-debug) \
		$(use_enable dii) \
		$(use_enable python) \
		--enable-libpst-shared
}
