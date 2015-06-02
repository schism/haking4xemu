# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library for cross-platform C split string functions"
HOMEPAGE="https://github.com/libyal/libcsplit"
LIBYAL_RELEASE="alpha"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv nls static-libs unicode"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror"
RDEPEND="${DEPEND}"
