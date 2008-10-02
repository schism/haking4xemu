# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion autotools

DESCRIPTION="RNDIS userspace daemon"
HOMEPAGE="http://sourceforge.net/projects/synce/"
ESVN_REPO_URI="http://synce.svn.sourceforge.net/svnroot/synce/trunk/${PN}@${PV}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE='hal'
DEPEND='hal? ( sys-apps/hal )
		!app-pda/usb-rndis-lite'
RDEPEND=${DEPEND}

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	eautoreconf
	econf $(use_enable hal)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
