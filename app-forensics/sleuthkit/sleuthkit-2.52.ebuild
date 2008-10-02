# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils autotools

SLOT=0
DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/sleuthkit/${P}.tar.gz"

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="ewf aff hfs"

DEPEND=" !sys-apps/dstat
	ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND} dev-perl/DateManip"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-fscheck_locale.patch"
	use hfs && sed -i 's/define TSK_USE_HFS 0/define TSK_USE_HFS 1/' tsk/tsk_fs_i.h
	eautoreconf || die "autoconf failed"
}

src_compile() {
	econf	$(use_enable aff afflib) \
			$(use_enable ewf)
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc docs/*.txt
}
