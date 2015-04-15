# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to provide generic file data cache functions"
HOMEPAGE="https://github.com/libyal/libfcache"
LIBYAL_RELEASE="alpha"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="iconv nls static-libs threads"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata"
RDEPEND="${DEPEND}"
