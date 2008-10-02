# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

MY_P="${PN}-src-${PV}"
DESCRIPTION="Snort plugin that allows automated blocking of IP addresses on several firewalls"
HOMEPAGE="http://www.snortsam.net/"
SRC_URI="http://www.snortsam.net/files/snortsam/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64"
IUSE="debug"

S=${WORKDIR}/${PN}
UNAME=`uname`

src_compile() {
	use debug && DEBUG='-DFWSAMDEBUG'
	for tool in all samtool ; do
		emake -C src/ \
			LDFLAGS="${LDFLAGS}" \
			CFLAGS="${CFLAGS} -D${UNAME} ${DEBUG}" \
			$tool || die "make $tool failed"
	done
}

src_install() {
	rm -Rf docs/CVS conf/CVS
	newinitd ${FILESDIR}/snortsam.init snortsam
	dobin snortsam samtool
	dodoc docs/* conf/*
	insinto /etc
	doins ${FILESDIR}/snortsam.conf
	case ${UNAME} in
		Linux*)
			sed -i "s:%%BASEFW%%:iptables eth0:g" ${D}/etc/snortsam.conf
		;;
		FreeBSD*)
			sed -i "s:%%BASEFW%%:ipfw2 em0 1 2:g" ${D}/etc/snortsam.conf
		;;
		*)
			sed -i "s:%%BASEFW%%:email 127.0.0.1 root snortsam:g" ${D}/etc/snortsam.conf
		;;
	esac
}

pkg_postinst() {
	elog
	elog "To use snortsam with snort, you'll have to compile snort with USE=snortsam."
	elog "Read the INSTALL file to configure snort for snortsam, and configure"
	elog "snortsam for your particular firewall."
	elog
}
