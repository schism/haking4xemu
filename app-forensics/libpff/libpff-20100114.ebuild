# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

MY_P=${P/${PN}/${PN}-alpha}
DESCRIPTION="Library and tools to access the PFF (Personal Folder File) format, used in PST and OST"
HOMEPAGE="http://www.sourceforge.net/projects/libpff"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x64-macos"
IUSE="debug unicode"

DEPEND="unicode? ( dev-libs/libuna )
		dev-libs/libbfio"
RDEPEND=${DEPEND}

src_configure() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		|| die "configure failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog AUTHORS README
	einfo "Further documentation on PFF and related formats are available at:"
	einfo "http://sourceforge.net/project/showfiles.php?group_id=237636&package_id=295724"
}
