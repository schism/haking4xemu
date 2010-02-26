# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils flag-o-matic autotools subversion

SLOT=0

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI=""
ESVN_REPO_URI="http://svn.sleuthkit.org/repos/${PN}/trunk"

LICENSE="GPL-2 IBM"
KEYWORDS=""

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

IUSE="aff ewf"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf\
		$(use_with aff afflib) \
		$(use_with ewf libewf) \
	|| die "configure failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README.txt NEWS.txt
}
