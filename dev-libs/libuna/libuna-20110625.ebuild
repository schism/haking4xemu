# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="http://www.sourceforge.net/projects/libuna"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="nls"
DEPEND="nls? ( virtual/libintl )
	virtual/libiconv"

src_configure() {
	econf --disable-rpath $(use_enable nls)
}
