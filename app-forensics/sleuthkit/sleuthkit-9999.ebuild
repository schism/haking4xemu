# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools git

SLOT=0
DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sleuthkit/sleuthkit"

LICENSE="GPL-2 IBM"
KEYWORDS=""

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )
	dev-perl/DateManip"

IUSE="aff ewf"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf\
		$(use_with aff afflib) \
		$(use_with ewf libewf)
}
