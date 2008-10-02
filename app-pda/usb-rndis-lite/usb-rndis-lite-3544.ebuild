# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion linux-mod

DESCRIPTION="RNDIS-lite kernel module"
HOMEPAGE="http://sourceforge.net/projects/synce/"
ESVN_REPO_URI="http://synce.svn.sourceforge.net/svnroot/synce/trunk/${PN}@${PV}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

MODULE_NAMES="rndis_host(usb:) usbnet(usb:) cdc_ether(usb:)"

pkg_setup() {
	linux-mod_pkg_setup

	if ! kernel_is 2 6; then
		die "This package works only with 2.6 kernel"
	fi

	if ! linux_chkconfig_present USB; then
		die "You need a kernel with enabled USB support"
	fi
}

src_compile() {
	BUILD_TARGETS='clean default'
	linux-mod_src_compile
}

pkg_preinst() {
	subversion_pkg_preinst
	linux-mod_pkg_preinst
}
