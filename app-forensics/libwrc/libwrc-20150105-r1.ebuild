# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to access the Windows Resource Compiler (WRC) format"
HOMEPAGE="https://github.com/libyal/libwrc"
LIBYAL_RELEASE="experimental"
LIBYAL_PYLIB="pywrc"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="${LIBYAL_IUSE}"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna
	app-forensics/libbfio
	app-forensics/libexe"
RDEPEND="${DEPEND}"
