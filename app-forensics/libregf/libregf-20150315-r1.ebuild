# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tools to access the Windows NT Registry File (REGF) format."
HOMEPAGE="http://github.com/libyal/libregf/"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pyregf"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fuse ${LIBYAL_IUSE}"
DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna
	app-forensics/libbfio
	fuse? ( sys-fs/fuse )"
RDEPEND="${DEPEND}"
