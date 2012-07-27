# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils flag-o-matic autotools

SLOT=0
MY_P=${P/_beta/b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${MY_P}.tar.gz"
LICENSE="GPL-2 IBM"
KEYWORDS=""

DEPEND="ewf? ( >=app-forensics/libewf-20110610 )
	qcow? ( dev-libs/libqcow )
	aff? ( app-forensics/afflib )
	dev-perl/DateManip"

IUSE="aff ewf qcow"

src_configure() {
	econf\
		$(use_with aff afflib) \
		$(use_with ewf libewf) \
		$(use_with qcow libqcow)
}
