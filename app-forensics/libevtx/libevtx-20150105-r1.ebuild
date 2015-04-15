# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tooling to access the Windows XML Event Log (EVTX) format"
HOMEPAGE="https://github.com/libyal/libevtx"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pyevtx"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="${LIBYAL_IUSE}"

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
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libfvalue
	dev-libs/libfwevt
	dev-libs/libfwnt
	app-forensics/libexe
	app-forensics/libregf
	app-forensics/libwrc
	dev-libs/libcdirectory
	dev-libs/libcsystem"
RDEPEND="${DEPEND}"
