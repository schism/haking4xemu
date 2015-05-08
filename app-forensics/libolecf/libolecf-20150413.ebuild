# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tools to access the OLE 2 Compound File (OLECF) format"
HOMEPAGE="https://github.com/libyal/libolecf"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pyolecf"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="${LIBYAL_IUSE} fuse"

DEPEND="${LIBYAL_DEPEND}
		fuse? ( sys-fs/fuse )
		dev-libs/libuna
		app-forensics/libbfio"
RDEPEND="${DEPEND}"
