# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/kismet-2008.05.1.ebuild,v 1.4 2009/04/15 13:43:25 hanno Exp $

inherit toolchain-funcs linux-info eutils

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
MY_P=${MY_P/kismet/kismet-old}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus gps ncurses suid"

DEPEND="net-libs/libpcap
	ncurses? ( sys-libs/ncurses )
	dbus? ( sys-apps/dbus )
	gps? (	media-gfx/imagemagick
			dev-libs/gmp
			sys-libs/zlib )"
RDEPEND="net-wireless/wireless-tools ${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		conf/kismet.conf.in

	# Don't strip and set correct mangrp
	sed -i -e 's| -s||g' \
		-e 's|@mangrp@|root|g' Makefile.in
}

src_compile() {
	# the configure script only honors '--disable-foo'
	local myconf
	if ! use gps ; then
		myconf="--disable-gpsmap"
	fi
	if ! use ncurses; then
		myconf="${myconf} --disable-curses --disable-panel"
	fi
	if ! use dbus; then
		myconf="${myconf} --disable-dbus"
	fi

	econf ${myconf} \
		--with-linuxheaders="${KV_DIR}" || die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use suid ; then
		fperms 4755 /usr/bin/kismet_{server,drone} \
			|| die "could not install setuid binaries"
	fi

	dodoc CHANGELOG README TODO docs/*

	newinitd "${FILESDIR}"/${PN}.initd kismet
	newconfd "${FILESDIR}"/${PN}.confd kismet
}
