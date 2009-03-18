# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P=${P/v/V}
MY_P="${MY_P}_Beta"
DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="https://www.volatilesystems.com/default/volatility"
SRC_URI="https://www.volatilesystems.com/${PN}/${PV}/${MY_P}.tar.gz \
	plugins? ( mirror://gentoo/${PN}-plugins-${PV}.tar.gz )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="plugins"

DEPEND=">=dev-lang/python-2.5
	plugins? ( dev-util/libdasm )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-setup.py.patch"
	sed -i -e "s:^#!.*:#!/usr/bin/python:" ${PN}
}
