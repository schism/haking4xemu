# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info eutils

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ncurses"

DEPEND="${RDEPEND}"
RDEPEND="net-wireless/wireless-tools
	net-libs/libpcap
	ncurses? ( sys-libs/ncurses )"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-Makefile.in.patch"

	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		"${S}"/conf/kismet.conf.in

	# Remove -s from install options
	sed -i -e 's| -s||g' "${S}/Makefile.in"
}

src_compile() {
	# the configure script only honors '--disable-foo'
	local myconf="--disable-gpsmap"

	if ! use ncurses; then
		myconf="${myconf} --disable-curses --disable-panel"
	fi

	econf ${myconf} \
		--with-linuxheaders="${KV_DIR}" || die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGELOG README TODO docs/*

	newinitd "${FILESDIR}/${PN}-init.d" kismet
	newconfd "${FILESDIR}/${PN}-conf.d" kismet
}
