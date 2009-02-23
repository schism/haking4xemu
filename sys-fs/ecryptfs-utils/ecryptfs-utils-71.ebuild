# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ecryptfs-utils/ecryptfs-utils-42.ebuild,v 1.1 2008/04/08 17:28:28 alonbl Exp $

inherit pam

DESCRIPTION="eCryptfs userspace utilities"
HOMEPAGE="http://launchpad.net/ecryptfs"
SRC_URI="http://launchpad.net/ecryptfs/trunk/${PV}/+download/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="suid pam gtk openssl pkcs11 gpg doc tpm"

RDEPEND=">=sys-apps/keyutils-1.0
	>=dev-libs/libgcrypt-1.2.0
	pam? ( sys-libs/pam )
	openssl? ( >=dev-libs/openssl-0.9.7 )
	pkcs11? (
		>=dev-libs/openssl-0.9.7
		>=dev-libs/pkcs11-helper-1.04
	)
	gpg? ( app-crypt/gpgme )
	gtk? ( x11-libs/gtk+ )"
# perl required for man generation
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	dev-lang/perl"

src_compile() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--with-pamdir=$(getpam_mod_dir) \
		$(use_enable pam) \
		$(use_enable openssl) \
		$(use_enable pkcs11 pkcs11-helper) \
		$(use_enable gpg) \
		$(use_enable gtk gui) \
		$(use_enable doc docs) \
		$(use_enable tpm tspi) \
		|| die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	use suid && fperms u+s /sbin/mount.ecryptfs
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
