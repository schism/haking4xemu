# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library for Windows NT data types"
HOMEPAGE="https://code.google.com/p/libfwnt"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSRVhHWHUxaDN4c3c/${PN}-experimental-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcnotify
	dev-libs/libcdata"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"
