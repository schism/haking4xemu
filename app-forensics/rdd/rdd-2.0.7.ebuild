# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Rdd is a forensic copy program"
HOMEPAGE="http://www.sf.net/projects/rdd"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/rdd/rdd-2.0.7.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="debug rawio gtk"
LICENSE="BSD"
SLOT="0"

DEPEND="gtk? ( >=x11-libs/gtk+-2
 >=gnome-base/libglade-2 )"

RDEPEND="${RDEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	use gtk || sed -i 's/AM_PATH_GTK_2_0//' configure.ac
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug tracing)\
		$(use_enable gtk gui)\
		$(use_enable rawio raw-device)
	emake
}

src_install() {
	# emake install has a sandbox violation in src/Makefile
	dobin src/rdd-copy
	dobin src/rdd-verify
	dobin src/rddi.py
	doman src/*.1
	dodoc doc/*.txt
	dosym rdd-copy /usr/bin/rdd
	dosym rddi.py /usr/bin/rddi
}
