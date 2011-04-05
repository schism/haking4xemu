# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="A system baselining and evidence collection tool"
HOMEPAGE="http://ftimes.sourceforge.net/FTimes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="pcre ssl static"

DEPEND=" sys-libs/zlib
	app-arch/bzip2
	ssl? ( >=dev-libs/openssl-0.9.7d )
	pcre? ( dev-libs/pcre )"

src_configure() {
	use static && sed -i -e "s/^FTIMES_LFLAGS.*/& -static/" ${S}/src/Makefile.in

	econf --sysconfdir=${EROOT}/etc/ftimes \
		$(use_with ssl) \
		$(use_with pcre) \
		$(use_with pcre xmagic)
}
