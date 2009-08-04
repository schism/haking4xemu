# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils subversion distutils

PLUGIN_VERSION="20090804"

DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="http://code.google.com/p/volatility/"
SRC_URI="plugins? ( mirror://gentoo/${PN}-plugins-${PLUGIN_VERSION}.tar.gz )"
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk/${PN^v}"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE="plugins"

DEPEND=""
RDEPEND="plugins? (
	dev-python/peutil
	dev-util/libdasm )"

NEED_PYTHON="2.5"

src_unpack() {
	subversion_src_unpack
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

		rm forensics/object.py forensics/win32/scan2.py lists.py

		cp *.py "${S}/memory_plugins/"
		cp -Rf forensics/* "${S}/forensics/"
		cp -Rf memory_plugins/* "${S}/memory_plugins/"
		cp -Rf memory_objects/* "${S}/memory_objects/"
	fi
}

src_prepare() {
	sed -i -e "s:^#!.*:#!/usr/bin/python:" ${PN}
}
