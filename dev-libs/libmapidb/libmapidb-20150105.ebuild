# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to access the Exchange MAPI database format"
HOMEPAGE="https://github.com/libyal/libmapidb"
LIBYAL_RELEASE="experimental"
#LIBYAL_PYLIB="pymapidb"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv nls static-libs unicode"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcnotify"
RDEPEND="${DEPEND}"
