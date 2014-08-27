# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library to support various Hash-based Message Authentication Codes (HMAC)"
HOMEPAGE="https://code.google.com/p/libhmac"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSUmg3ekttWGhmeHc/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="unicode"

DEPEND=" dev-libs/openssl
	dev-libs/libcerror
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libcfile
	dev-libs/libcpath
	dev-libs/libuna"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
    econf $(use_enable unicode wide-character-type)
}
