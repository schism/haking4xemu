# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tools to access the Microsoft Internet Explorer (MSIE) Cache File (index.dat) files"
HOMEPAGE="https://github.com/libyal/libmsiecf/"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pymsiecf"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="${LIBYAL_IUSE}"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna
	app-forensics/libbfio"
RDEPEND="${DEPEND}"
