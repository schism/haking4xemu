# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils

MY_P=${P/[\.]/-}
MY_P=${MY_P/./-R}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+client kernel_linux +pcap pcre plugins +suid"

DEPEND="pcap? ( net-libs/libpcap )
	pcre? ( dev-libs/libpcre )
	kernel_linux? ( dev-libs/libnl )
	client? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"
KISMET_PLUGINS="ptw spectools"

pkg_setup() {
	if has_version "=net-libs/libpcap-1.0.1_pre*" ; then
		ewarn "Detected development version of libpcap"
		ewarn "Kismet will work, but this version of libpcap has a broken"
		ewarn "get_selectable_fd() implementation that will cause Kismet to"
		ewarn "consume 100% CPU and disable local sources.  Use the 1.0.0"
		ewarn "series to avoid this"
	fi
	if use suid ; then
		enewgroup kismet
	fi
}

src_prepare() {
	sed -i -e "s:# *logprefix=.*:logprefix=/tmp:" conf/kismet.conf.in
}

src_configure() {
	econf $(use_enable kernel_linux linuxwext) \
		$(use_enable client) \
		$(use_enable pcre) \
		$(use_enable pcap) \
		|| die "econf failed"
}

src_compile() {
	emake dep || die "emake dep failed"
	emake || die "emake failed"
	if use plugins ; then
		local plugin
		for plugin in $KISMET_PLUGINS ; do
			emake -C "plugin-$plugin" KIS_SRC_DIR="${S}" \
				|| die "emake $plugin failed"
		done
	fi
}

src_install() {
	emake DESTDIR="${D}" commoninstall || die "emake install failed"

	insinto /etc
	doins conf/kismet.conf
	doins conf/kismet_drone.conf

	dodoc README*
	newinitd "${FILESDIR}"/${PN}.initd kismet
	newconfd "${FILESDIR}"/${PN}.confd kismet

	if use plugins ; then
		local plugin
		for plugin in $KISMET_PLUGINS ; do
			emake -C "plugin-$plugin" KIS_DEST_DIR="${D}/usr" install
		done
	fi

	if use suid ; then
		dobin kismet_capture
		fowners root:kismet /usr/bin/kismet_capture
		fperms 4550 /usr/bin/kismet_capture \
			|| die "could not install setuid helper"
		elog ""
		elog "Kismet has been installed with a setuid-root helper binary"
		elog "to enable minimal-root operation.  Users need to be part of"
		elog "the 'kismet' group to perform captures from physical devices"
	fi
}
