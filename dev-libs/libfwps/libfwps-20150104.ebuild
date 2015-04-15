# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library for Windows Property Store data types"
HOMEPAGE="https://github.com/libyal/libfwps"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pyfwps"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="${LIBYAL_IUSE}"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libuna
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libfole"
RDEPEND="${DEPEND}"
