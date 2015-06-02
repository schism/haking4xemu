# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library to support cross-platform AES encryption"
HOMEPAGE="https://github.com/libyal/libcaes"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pycaes"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv nls python static-libs unicode"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libcstring
	dev-libs/libcerror
	dev-libs/openssl"
RDEPEND="${DEPEND}"
