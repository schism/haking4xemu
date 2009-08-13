# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils subversion distutils

DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="http://code.google.com/p/volatility/"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk/${PN/#v/V}"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

NEED_PYTHON="2.5"

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	epatch ${FILESDIR}/${P}-setup.py.patch
	sed -i -e "s:^#!.*:#!/usr/bin/python:" ${PN}
}
