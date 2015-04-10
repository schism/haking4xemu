# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils autotools-utils user

DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="mirror://sourceforge/silc/silc/server/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6 debug threads"

DEPEND=""
RDEPEND="${DEPEND}
	!<=net-im/silc-client-1.0.1"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		"--disable-optimizations"
		"--disable-asm"
		"--with-logsdir=/var/log/${PN}"
		"--with-silcd-pid-file=/var/run/silcd.pid"
		"--docdir=/usr/share/doc/${PF}"
		"--sysconfdir=/etc/silc"
		"--datadir=/usr/share/${PN}"
		"--datarootdir=/usr/share/${PN}"
		"--mandir=/usr/share/man"
		"--includedir=/usr/include/${PN}"
		"--libdir=/usr/$(get_libdir)/${PN}"
		$(use_enable ipv6)
		$(use_enable debug)
		$(use_with threads pthreads)
	)
	autotools-utils_src_configure
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.conf

	fperms 750 /etc/silc
	keepdir /var/log/${PN}

	newinitd "${FILESDIR}/silcd.initd" silcd

	sed -i \
		-e 's:10.2.1.6:0.0.0.0:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		-e 's:Group = "nobody";:Group = "silcd";:' \
		"${D}"/etc/silc/silcd.conf
}

pkg_postinst() {
	enewuser silcd
	if [ ! -f "${ROOT}"/etc/silc/silcd.prv ] ; then
		einfo "Creating key pair in /etc/silc"
		silcd -C "${ROOT}"/etc/silc
		chmod 600 "${ROOT}"/etc/silc/silcd.{prv,pub}
	fi
}
