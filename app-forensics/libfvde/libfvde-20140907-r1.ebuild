# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5

DESCRIPTION="Library and tools for reading FileVault Drive Encryption (FVDE) encrypted volumes."
HOMEPAGE="https://github.com/libyal/libfvde/"
LIBYAL_RELEASE="experimental"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug iconv nls static static-libs threads unicode"

DEPEND="${LIBYAL_DEPEND}
	dev-libs/libuna
	app-forensics/libbfio
	sys-fs/fuse
	dev-libs/libxml2
	dev-libs/openssl"
RDEPEND="${DEPEND}"
