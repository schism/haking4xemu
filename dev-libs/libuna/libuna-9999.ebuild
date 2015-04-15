# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Library to support Unicode and ASCII (byte string) conversions"
HOMEPAGE="https://github.com/libyal/libuna/"
LIBYAL_RELEASE="alpha"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="iconv nls static static-libs unicode"
DEPEND="${LIBYAL_DEPEND}"

src_configure() {
	# these all also depend on libuna, introducing circular dependencies.
	# Use the local copy for this core lib.
	local libyal_econf=(
		"--with-libcstring=no"
		"--with-libcerror=no"
		"--with-libcdatetime=no"
		"--with-libclocale=no"
		"--with-libcnotify=no"
		"--with-libcfile=no"
		"--with-libcsystem=no"
	)
	libyal-r1_src_configure
}
