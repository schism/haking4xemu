# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library for GUID/UUID data types"
HOMEPAGE="https://code.google.com/p/libfguid"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSRXdGUVRlX2JQWk0/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/libcerror"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"
