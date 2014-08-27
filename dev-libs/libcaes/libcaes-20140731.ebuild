# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Library to support cross-platform AES encryption"
HOMEPAGE="https://code.google.com/p/libcaes"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSRzhrM2s3c1JnMkE/${PN}-alpha-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="unicode"

DEPEND="dev-libs/libcerror
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_DATE}"

src_configure() {
    econf $(use_enable unicode wide-character-type)
}
