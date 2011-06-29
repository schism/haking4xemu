# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Library that implements the AFF image standard"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86 ~x86-macos ~x64-macos"
IUSE="ewf fuse python s3 threads"

DEPEND="
	ewf? ( app-forensics/libewf )
	fuse? ( sys-fs/fuse )
	python? ( dev-lang/python )
	s3? ( net-misc/curl )
	dev-libs/expat
	sys-libs/readline
	sys-libs/ncurses
	sys-libs/zlib
	dev-libs/openssl"

src_configure() {
	econf --enable-qemu \
		$(use_enable fuse) \
		$(use_enable ewf libewf) \
		$(use_enable python) \
		$(use_enable s3) \
		$(use_enable threads threading)
}
