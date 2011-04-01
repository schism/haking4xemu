# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Library and tools to access the Windows Shortcut File (LNK) Format"
HOMEPAGE="http://liblnk.sourceforge.net/"
SRC_URI="mirror://sourceforge/liblnk/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="debug unicode"

DEPEND="
	dev-libs/libbfio
	dev-libs/libuna"
RDEPEND="${DEPEND}"

src_configure() {
	econf	$(use_enable debug debug-output) \
			$(use_enable debug verbose-output) \
			$(use_enable unicode wide-character-type) \
			|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}