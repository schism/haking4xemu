# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# schism@subverted.org

EAPI=5

inherit eutils autotools-utils user

DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="mirror://sourceforge/silc/silc/server/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug gmp iconv ipv6 socks5 threads"

DEPEND="virtual/pkgconfig
	iconv? ( virtual/iconv )
	gmp? ( dev-libs/gmp )
	socks5? ( net-proxy/dante )"
RDEPEND="${DEPEND}
	!<=net-im/silc-client-1.0.1"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		--with-logsdir="${EPREFIX}/var/log/${PN}"
		--with-silcd-pid-file="${EPREFIX}/var/run/silcd.pid"
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--sysconfdir="${EPREFIX}/etc/silc"
		--datadir="${EPREFIX}/usr/share/${PN}"
		--datarootdir="${EPREFIX}/usr/share/${PN}"
		--mandir="${EPREFIX}/usr/share/man"
		--includedir="${EPREFIX}/usr/include/${PN}"
		--libdir="${EPREFIX}/usr/$(get_libdir)/${PN}"
		--disable-optimizations
		--disable-asm
		$(use_enable ipv6)
		$(use_enable debug)
		$(use_with threads pthreads)
	)
	if use gmp; then
		# their --with-gmp is one-way
		myeconfargs+=( --with-gmp )
	fi
	if ! use iconv; then
		# their --with-iconv is inverted but automagic
		myeconfargs+=( --with-iconv )
	fi
	if use socks5; then
		# their --with-socks5 only works one way
		myeconfargs+=( --with-socks5 )
	fi
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	#emake -j1 DESTDIR="${D}" install || die "make install failed"

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
	if [ ! -f "${EPREFIX}"/etc/silc/silcd.prv ] ; then
		einfo "Creating key pair in /etc/silc"
		silcd -C "${EPREFIX}"/etc/silc
		chmod 600 "${EPREFIX}"/etc/silc/silcd.{prv,pub}
	fi
}
