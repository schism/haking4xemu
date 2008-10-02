# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A system baselining and evidence collection tool"
HOMEPAGE="http://ftimes.sourceforge.net/FTimes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="pcre ssl static"

DEPEND=" sys-libs/zlib
	app-arch/bzip2
	ssl? ( >=dev-libs/openssl-0.9.7d )
	pcre? ( dev-libs/pcre )"

src_compile() {
	use static && sed -i -e "s/^FTIMES_LFLAGS.*/& -static/" ${S}/src/Makefile.in
	
	econf --sysconfdir=/etc/ftimes\
		$(use_with ssl)\
		$(use_with pcre)\
		$(use_with pcre xmagic) || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	einstall etcdir=${D}/etc/ftimes || die "install failed"
}
