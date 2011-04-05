# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

EAPI="4"

MY_PV=${PV/_p/-r}
DESCRIPTION="Patched version of dd with features intended for forensic acquisition of data"
HOMEPAGE="http://dc3dd.sourceforge.net"
SRC_URI="mirror://sourceforge/dc3dd/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="nls"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable nls) --enable-hdparm
}
