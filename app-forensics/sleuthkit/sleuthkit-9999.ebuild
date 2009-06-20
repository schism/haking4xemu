# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils flag-o-matic autotools subversion

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI=""
ESVN_REPO_URI="http://svn.sleuthkit.org/repos/${PN}/trunk"

LICENSE="GPL-2 IBM"
SLOT=0
KEYWORDS=""
IUSE="ewf aff hfs"

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf	$(use_enable aff afflib) \
			$(use_enable ewf) \
		|| die "configure failed"
}

src_compile() {
	use hfs && append-flags "-DTSK_USE_HFS"
	default_src_compile
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc docs/*.txt README.txt CHANGES.txt
}
