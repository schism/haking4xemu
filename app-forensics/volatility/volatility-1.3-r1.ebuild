# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils distutils

MY_P=${P/v/V}
MY_P="${MY_P}_Beta"
PLUGIN_VERSION="20090804"

DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="https://www.volatilesystems.com/default/volatility"
SRC_URI="https://www.volatilesystems.com/${PN}/${PV}/${MY_P}.tar.gz \
	plugins? ( mirror://gentoo/${PN}-plugins-${PLUGIN_VERSION}.tar.gz )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="plugins"

DEPEND=""
RDEPEND="plugins? (
	dev-python/peutil
	dev-util/libdasm )"

NEED_PYTHON="2.5"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack
	if use plugins; then
		cd "${WORKDIR}"
		unpack ${A}
		cd "${WORKDIR}/${PN}-plugins-${PLUGIN_VERSION}"

		for ZFILE in *.zip; do
			unzip -o $ZFILE
		done
		for ZFILE in *.tar.gz; do
			tar -xzf $ZFILE
		done

		rm forensics/object.py forensics/win32/scan2.py
		mv lists.py forensics/win32

		cp *.py "${S}/memory_plugins/"
		cp -Rf forensics/* "${S}/forensics/"
		cp -Rf memory_plugins/* "${S}/memory_plugins/"
		cp -Rf memory_objects/* "${S}/memory_objects/"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-setup.py.patch"
	sed -i -e "s:^#!.*:#!/usr/bin/python:" ${PN}
	sed -i -e 's/import sha/import hashlib/' forensics/win32/crashdump.py
}
