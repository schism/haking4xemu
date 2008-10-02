# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit pam

DESCRIPTION="This is the PAM to RADIUS authentication module. It allows any
PAM-capable machine to become a RADIUS client for authentication and accounting
requests. You will need a RADIUS server to perform the actual authentication."
HOMEPAGE="http://www.freeradius.org/pam_radius_auth/"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

src_install() {
	dopammod pam_radius_auth.so
	dodoc ChangeLog USAGE INSTALL pam_radius_auth.conf
	keepdir /etc/raddb
}

pkg_postinst() {
	elog "See docs in /usr/share/doc/${PF} for an /etc/raddb/server"
	elog "example and PAM configuration"
}
