# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${P/\./-}
MY_P=${MY_P/./-R}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x64-macos ~x86-macos"

KISMET_PLUGINS="autowep btscan ptw spectools"
IUSE="+client kernel_linux +pcre +pcap +suid ${KISMET_PLUGINS}"

RDEPEND="pcap? ( net-libs/libpcap )
	client? ( sys-libs/ncurses )
	kernel_linux? (
		dev-libs/libnl
		sys-libs/libcap
	)
	pcre? ( dev-libs/libpcre )
	btscan? ( net-wireless/bluez )
	ptw? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e 's:# *logprefix=.*:logprefix=/tmp:' conf/kismet.conf.in \
		|| die "failed to change logprefix"
}

src_configure() {
	econf --with-suidgroup=kismet \
		$(use_enable client) \
		$(use_enable kernel_linux linuxwext) \
		$(use_enable pcre) \
		$(use_enable pcap)
}

src_compile() {
	emake || die "emake failed"

	for plugin in ${KISMET_PLUGINS}; do
		if use ${plugin}; then
			emake -C plugin-${plugin} KIS_SRC_DIR="${S}" \
				|| die "emake in plugin-${plugin} failed"
		fi
	done
}

src_install() {
	emake DESTDIR="${D}" commoninstall || die "emake install failed"

	for plugin in ${KISMET_PLUGINS}; do
		if use ${plugin}; then
			emake -C plugin-${plugin} KIS_SRC_DIR="${S}" DESTDIR="${D}" install \
				|| die "emake install in plugin-${plugin} failed"
		fi
	done

	dodoc README docs/{DEVEL.client,README.newcore} || die

	insinto /etc
	doins conf/kismet{,_drone}.conf || die

	newinitd "${FILESDIR}"/${PN}.initd kismet || die
	newconfd "${FILESDIR}"/${PN}.confd kismet || die

	if use suid; then
		dobin kismet_capture || die
	fi
}

pkg_preinst() {
	if use suid; then
		enewgroup kismet
		fowners root:kismet /usr/bin/kismet_capture
		fperms 4550 /usr/bin/kismet_capture || die
		elog "Kismet has been installed with a setuid-root helper binary"
		elog "to enable minimal-root operation.  Users need to be part of"
		elog "the 'kismet' group to perform captures from physical devices."
	fi
}
