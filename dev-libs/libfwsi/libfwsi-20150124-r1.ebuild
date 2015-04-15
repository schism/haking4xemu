# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to access the Windows Shell Item format"
HOMEPAGE="https://github.com/libyal/libfwsi"
LIBYAL_RELEASE="experimental"
LIBYAL_PYLIB="pyfwsi"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug iconv nls python static-libs threads"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libuna
	dev-libs/libfdatetime
	dev-libs/libfole
	dev-libs/libfguid
	dev-libs/libfwps
	dev-libs/libuna"
RDEPEND="${DEPEND}"
