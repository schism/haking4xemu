# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils toolchain-funcs

MY_P="${PN}-src-${PV}"
DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="http://www.snortsam.net/files/snortsam/${MY_P}.tar.gz"

LICENSE="BSD-2 as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-ugly----lines.diff
	sed -i -e "s:sbin/functions.sh:etc/init.d/functions.sh:" \
			-e "s: -O2 : ${CFLAGS} :" \
			-e "s:gcc :$(tc-getCC) :" \
			-e "s:\( -o ../snortsam\): ${LDFLAGS}\1:" makesnortsam.sh || die "sed failed"
	find "${S}" -depth -type d -name CVS -exec rm -rf \{\} \;
}

src_compile() {
	sh makesnortsam.sh || die "makesnortsam.sh failed"
}

src_install() {
	dobin snortsam || die "dobin failed"
	dodoc docs/* conf/*
}

pkg_postinst() {
	elog "To use snortsam with snort, you'll have to compile snort with USE=snortsam."
	elog "Read the INSTALL file to configure snort for snortsam, and configure"
	elog "snortsam for your particular firewall."
}
