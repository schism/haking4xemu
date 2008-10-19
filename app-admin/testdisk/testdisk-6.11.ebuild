# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-6.10.ebuild,v 1.1 2008/07/19 14:36:35 dragonheart Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Checks and undeletes partitions + PhotoRec, signature based recovery tool"
HOMEPAGE="http://www.cgsecurity.org/wiki/TestDisk"
#SRC_URI="http://www.cgsecurity.org/${P}.tar.bz2"
SRC_URI="http://www.cgsecurity.org/${P}-WIP.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
KEYWORDS=""
IUSE="ewf iconv jpeg ntfs reiserfs static"
# WARNING: reiserfs support does NOT work with reiserfsprogs
# you MUST use progsreiserfs-0.3.1_rc8 (the last version ever released).
DEPEND=">=sys-libs/ncurses-5.2
		ewf? ( app-forensics/libewf )
		iconv? ( virtual/iconv )
		jpeg? ( media-libs/jpeg )
	  	ntfs? ( >=sys-fs/ntfsprogs-2.0.0 )
	  	reiserfs? ( >=sys-fs/progsreiserfs-0.3.1_rc8 )
	  	>=sys-fs/e2fsprogs-libs-1.40
		dev-libs/openssl
		sys-libs/zlib"
RDEPEND="!static? ( ${DEPEND} )"

S="${WORKDIR}/${P}-WIP"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-configure.ac.patch
	eautoreconf
}

src_compile() {

	# this is static method is the same used by upstream for their 'static' make
	# target, but better, as it doesn't break.
	use static && append-ldflags -static

	econf --with-ncurses --enable-sudo --with-ext2fs \
		$(use_with ewf) \
		$(use_with iconv) \
		$(use_with jpeg) \
		$(use_with ntfs) \
		$(use_with reiserfs) \
	|| die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	[ "$PF" != "$P" ] && mv "${D}"/usr/share/doc/${P} "${D}"/usr/share/doc/${PF}
}
