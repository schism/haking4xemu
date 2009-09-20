# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

SLOT=0

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"

LICENSE="GPL-2 IBM"
KEYWORDS="~amd64 ~arm ~hppa ~s390 ~sparc ~x86"

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

IUSE="ewf aff hfs"

src_compile() {
	use hfs && append-flags "-DTSK_USE_HFS"
	econf $(use_enable aff afflib) \
		$(use_enable ewf) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc docs/*.txt README.txt CHANGES.txt TODO.txt
}
