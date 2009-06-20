# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit eutils

MY_P=${P/[\.]/-}
MY_P=${MY_P/_rc/-RC}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+client +pcap pcre plugins suid"

DEPEND="pcap? ( net-libs/libpcap )
	pcre? ( dev-libs/libpcre )
	kernel_linux? ( dev-libs/libnl )
	client? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}
	net-wireless/wireless-tools"
KISMET_PLUGINS="ptw spectools"

src_prepare() {
	sed -i -e "s:# *logprefix=.*:/tmp:" conf/kismet.conf.in
}

src_configure() {
	econf $(use_enable client)\
		$(use_enable pcre) \
		$(use_enable pcap) || die "econf failed"
}

src_compile() {
	emake dep || die "emake dep failed"
	emake || die "emake failed"
	if use plugins ; then
		local plugin
		for plugin in $KISMET_PLUGINS ; do
			emake -C plugin-$plugin KIS_SRC_DIR="${S}" \
				|| die "emake $plugin failed"
		done
	fi
}

src_install () {
	local INST='install'
	if use suid ; then
		INST='suidinstall'
	fi
	emake DESTDIR="${D}" ${INST} || die "emake install failed"
	dodoc README*
	newinitd "${FILESDIR}"/${PN}-init.d kismet
	newconfd "${FILESDIR}"/${PN}-conf.d kismet
	if use plugins ; then
		local plugin
		for plugin in $KISMET_PLUGINS ; do
			make -C plugin-$plugin KIS_DEST_DIR="${D}/usr" install
		done
	fi
}
