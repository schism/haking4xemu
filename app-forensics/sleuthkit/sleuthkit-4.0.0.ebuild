# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

SLOT=0
DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"
LICENSE="GPL-2 IBM"
KEYWORDS="~amd64 ~arm ~hppa ~s390 ~sparc ~x86 ~x86-macos ~x64-macos"

DEPEND="ewf? ( >=app-forensics/libewf-20110610 )
	qcow? ( dev-libs/libqcow )
	vhdi? ( dev-libs/libvhdi )
	aff? ( app-forensics/afflib )
	dev-perl/DateManip"

IUSE="aff +ewf +qcow +vhdi"

AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	epatch ${FILESDIR}/${P}-virtual-support.patch
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_with aff afflib)
		$(use_with ewf libewf)
		$(use_with qcow libqcow)
		$(use_with vhdi libvhdi)
	)
	autotools-utils_src_configure
}
