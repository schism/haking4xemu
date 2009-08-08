# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils distutils

MY_P=${P^v}
MY_P="${MY_P}_Beta"

DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="https://www.volatilesystems.com/default/volatility"
SRC_URI="https://www.volatilesystems.com/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

NEED_PYTHON="2.5"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-"{setup.py,sys-path}.patch
	sed -i -e "s:^#!.*:#!/usr/bin/python:" ${PN}
	sed -i -e 's/import sha/import hashlib/' forensics/win32/crashdump.py
}
