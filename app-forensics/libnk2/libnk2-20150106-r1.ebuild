# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tooling to support the Microsoft Outlook Nickfile (NK2) format"
HOMEPAGE="http://github.com/libyal/libnk2/"
LIBYAL_RELEASE="alpha"
LIBYAL_PYLIB="pynk2"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="${LIBYAL_IUSE}"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna
	app-forensics/libbfio"
RDEPEND="${DEPEND}"
