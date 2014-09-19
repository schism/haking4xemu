# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="A forensic carver that ignores file system structures"
HOMEPAGE="http://www.forensicswiki.org/wiki/Bulk_extractor"
SRC_URI="http://digitalcorpora.org/downloads/bulk_extractor/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="aff boost ewf exiv hashdb java rar"
AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

CDEPEND="boost? ( dev-libs/boost[threads] )
	java? ( virtual/jre )
	ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )
	hashdb? ( virtual/libiconv )
	exiv? ( media-gfx/exiv2 )
	dev-db/sqlite
	dev-libs/expat
	dev-libs/openssl
	sys-libs/zlib"
DEPEND="${CDEPEND}
	>=sys-devel/autoconf-2.57"
RDEPEND="${CDEPEND}"

DOCS=( AUTHORS ChangeLog README doc/2013.COSE.bulk_extractor.pdf doc/bulk_extractor.html )

PATCHES=( "$FILESDIR/${P}-autoconf_orthogonal.patch" )

src_configure () {
	local myeconfargs=(
		$(use_enable aff afflib)
		$(use_enable ewf libewf)
		$(use_enable exiv exiv2)
		$(use_enable hashdb)
		$(use_enable java BEViewer)
		$(use_enable rar)
		'--disable-lightgrep'
		'--without-opt'
	)
	autotools-utils_src_configure
}
