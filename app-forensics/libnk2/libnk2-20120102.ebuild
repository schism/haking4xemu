# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library and tooling to support the Microsoft Outlook Nickfile (NK2) format"
HOMEPAGE="http://www.sourceforge.net/projects/libnk2"
SRC_URI="mirror://sourceforge/${PN}/${PN}-alpha/${MY_P}/${MY_P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="debug nls unicode"

DEPEND="nls? ( virtual/libintl )
	dev-libs/libuna
	app-forensics/libbfio"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
}
