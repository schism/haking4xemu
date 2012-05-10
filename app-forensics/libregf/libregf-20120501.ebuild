# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library and tools to access the Windows NT Registry File (REGF) format."
HOMEPAGE="http://www.sourceforge.net/projects/libregf"
SRC_URI="mirror://sourceforge/libregf/${PN}-alpha/${MY_P}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug fuse nls python unicode"

DEPEND="nls? (
			virtual/libiconv
			virtual/libintl
		)
	dev-libs/libuna
	dev-libs/libbfio
	fuse? ( sys-fs/fuse )
	python? ( dev-lang/python )"

src_configure() {
	econf --disable-rpath \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable python) \
		$(use_with fuse libfuse)
}
