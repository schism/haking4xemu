# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tools for reading FileVault Drive Encryption (FVDE) encrypted volumes."
HOMEPAGE="http://github.com/libyal/libfvde/"
LIBYAL_RELEASE="experimental"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug iconv nls static static-libs threads unicode"

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
	dev-libs/libfguid
	dev-libs/libfvalue
	dev-libs/libhmac
	dev-libs/libcaes
	dev-libs/libcsystem
	sys-fs/fuse
	dev-libs/libxml2
	dev-libs/openssl"
RDEPEND="${DEPEND}"
