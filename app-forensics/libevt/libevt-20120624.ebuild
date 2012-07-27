# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-experimental}
DESCRIPTION="Library and tooling to access the Windows Event Log (EVT) format"
HOMEPAGE="https://code.google.com/p/libevt/"
SRC_URI="https://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos ~x86-macos"
IUSE="debug nls python unicode"

DEPEND="nls? ( virtual/libiconv
			virtual/libintl )
		unicode? ( dev-libs/libuna )
		python? ( dev-lang/python )
		dev-libs/libbfio
		app-forensics/libregf
		"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable python)
}
