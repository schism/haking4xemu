# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-0.18.ebuild,v 1.2 2009/04/01 12:26:44 patrick Exp $

inherit eutils

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="http://btrfs.wiki.kernel.org/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/mason/btrfs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="acl python"

DEPEND="acl? (
			sys-apps/acl
			sys-fs/e2fsprogs
		)"
RDEPEND="${DEPEND}
	python? ( dev-python/matplotlib )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apply hot fixes
	#epatch "${FILESDIR}/${P}-hotfix.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		all || die
	if use acl; then
		emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
			convert || die
	fi
}

src_install() {
	into /
	dosbin btrfs-show
	dosbin btrfs-vol
	dosbin btrfs-image
	dosbin btrfsctl
	dosbin btrfstune
	dosbin btrfsck
	# fsck will segfault if invoked at boot, so do not make this link
	#dosym btrfsck /sbin/fsck.btrfs
	#newsbin debug-tree btrfs-debug-tree
	newsbin mkfs.btrfs mkbtrfs
	dosym mkbtrfs /sbin/mkfs.btrfs
	if use acl; then
		dosbin btrfs-convert
	else
		ewarn "Note: btrfs-convert not built/installed (requires acl USE flag)"
	fi

	if use python; then
		into /usr
		newbin bcp btrfs-bcp
		newbin show-blocks btrfs-show-blocks
	fi

	dodoc INSTALL
}

pkg_postinst() {
	ewarn "NOTE:    This version of btrfs-progs corresponds to and should only"
	ewarn "         be used with the version of btrfs included in the"
	ewarn "         Linux 2.6.29-rc2 kernel."
	ewarn ""
	ewarn "WARNING: This version should NOT be used with earlier versions"
	ewarn "         of the standaline btrfs module package!"
	ewarn ""
	ewarn "         If you are using standalone btrfs-0.16 or earlier,"
	ewarn "         use a matching version of btrfs-progs."
}
