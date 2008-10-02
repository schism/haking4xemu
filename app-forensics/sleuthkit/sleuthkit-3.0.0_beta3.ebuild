# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

SLOT=3
MY_P=${P/_beta/b}

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="http://sleuthkit.org/betas/${MY_P}.tar.gz"

LICENSE="GPL-2 IBM"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="ewf aff hfs"
S="${WORKDIR}/${MY_P}"

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND} dev-perl/DateManip"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	use hfs && sed -i 's/define TSK_USE_HFS 0/define TSK_USE_HFS 1/' tsk3/fs/tsk_fs_i.h
}

src_compile() {
	append-flags -fPIC
	econf	$(use_enable aff afflib) \
			$(use_enable ewf) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc docs/*.txt README.txt CHANGES.txt TODO.txt
}
