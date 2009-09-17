# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-1.1.8.ebuild,v 1.2 2009/03/14 18:30:12 armin76 Exp $
EAPI="2"

inherit eutils

DESCRIPTION="SDK for the SILC protocol"
HOMEPAGE="http://silcnet.org/"
SRC_URI="http://silcnet.org/download/toolkit/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug ipv6 threads"

RDEPEND=""
DEPEND="dev-util/pkgconfig"

src_prepare() {
	# They have incorrect DESTDIR usage
	sed -i '/\$(srcdir)\/tutorial/s/\$(prefix)/\$(docdir)/' "${S}"/Makefile.in
	sed -i \
		"s/^\(pkgconfigdir =\) \$(libdir)\/pkgconfig/\1	\/usr\/$(get_libdir)\/pkgconfig/"\
		"${S}"/lib/Makefile.in
}

src_configure() {
	econf \
		--datadir=/usr/share/${PN} \
		--datarootdir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--includedir=/usr/include/${PN} \
		--sysconfdir=/etc/silc \
		--libdir=/usr/$(get_libdir)/${PN} \
		--docdir=/usr/share/doc/${PF} \
		--disable-optimizations \
		--with-simdir=/usr/$(get_libdir)/${PN}/modules \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_with threads pthreads) || die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
}
