# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library for generic file value functions"
HOMEPAGE="https://github.com/libyal/libfvalue"
LIBYAL_RELEASE="alpha"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug iconv nls static-libs threads"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libcnotify
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libfwnt
	dev-libs/libuna"
RDEPEND="${DEPEND}"
