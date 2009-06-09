# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="Library that implements the AFF image standard"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

EAPI="2"
LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ewf fuse ncurses python qemu readline s3 threads"

DEPEND="
	ewf? ( app-forensics/libewf )
	fuse? ( sys-fs/fuse )
	ncurses? ( sys-libs/ncurses )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	s3? ( net-misc/curl dev-libs/expat )
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND=${DEPEND}

src_prepare() {
	mkdir m4
	cp ${FILESDIR}/${P}-acinclude.m4 acinclude.m4
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable fuse) \
		$(use_enable ewf libewf) \
		$(use_enable python) \
		$(use_enable qemu) \
		$(use_enable s3) \
		$(use_enable threads threading)
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	use s3 || {
		rm -f "${D}/usr/bin/s3"
	}
	dodoc BUGLIST.txt README ChangeLog AUTHORS
}
