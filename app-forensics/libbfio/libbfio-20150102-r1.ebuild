# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Library that provides basic file input/output abstraction"
HOMEPAGE="https://github.com/libyal/libbfio/"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls iconv threads unicode"
DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna"
RDEPEND="${DEPEND}"
