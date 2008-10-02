# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://www.uitwisselplatform.nl/projects/libewf/"
SRC_URI="http://www.uitwisselplatform.nl/frs/download.php/529/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="unicode rawio debug"

DEPEND="sys-fs/e2fsprogs
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND=${DEPEND}

src_compile() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio raw-access) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output)

	emake
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README doc/tests.txt
}
