# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${P}rc2"
MY_P=${MY_P/-/_}
DESCRIPTION="An ICAP server"
HOMEPAGE="http://www.sourceforge.net/projects/c-icap"
SRC_URI="mirror://sourceforge/c-icap/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="clamav perl"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	if ! use clamav;then
		MY_CONF="${MY_CONF} --with-clamav=no"
	fi
	if ! use perl;then
		MY_CONF="${MY_CONF} --with-perl=no"
	fi

	econf ${MY_CONF}
	emake || die "compile failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc README
}
