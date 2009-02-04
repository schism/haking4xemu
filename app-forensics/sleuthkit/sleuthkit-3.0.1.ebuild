# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic autotools

SLOT=0

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"

LICENSE="GPL-2 IBM"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="ewf aff hfs"

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}"

#src_unpack() {
	#unpack ${A}
	#cd "${S}"
	## AC_FUNC_REALLOC in configure.ac that hasn't been propagated
	#eautoreconf
#}

src_compile() {
	use hfs && append-flags "-DTSK_USE_HFS"
	econf	$(use_enable aff afflib) \
			$(use_enable ewf) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc docs/*.txt README.txt CHANGES.txt
}
