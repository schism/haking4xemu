# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library for formatting Update Sequence Number (USN) Journal data types"
HOMEPAGE="https://github.com/libyal/libfusn"
LIBYAL_RELEASE="experimental"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug iconv nls static-libs"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/libcnotify
	dev-libs/libuna
	dev-libs/libcfdatetime"
RDEPEND="${DEPEND}"
