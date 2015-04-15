# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to support optical disc (split) RAW formats"
HOMEPAGE="https://github.com/libyal/libodraw/"
LIBYAL_RELEASE="alpha"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug iconv nls threads static static-libs unicode"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libuna
	dev-libs/libcfile
	dev-libs/libcpath
	app-forensics/libbfio
	dev-libs/libhmac
	dev-libs/libcsystem"
RDEPEND="${DEPEND}"

src_configure() {
	local libyal_econf=(
		"--with-libcstring=no"
		"--with-libcerror=no"
		"--with-libcthreads=no"
		"--with-libcdata=no"
		"--with-libclocale=no"
		"--with-libcnotify=no"
		"--with-libcsplit=no"
		"--with-libcfile=no"
		"--with-libcpath=no"
		"--with-libhmac=no"
		"--with-libcsystem=no"
	)
	libyal-r1_src_configure
}
