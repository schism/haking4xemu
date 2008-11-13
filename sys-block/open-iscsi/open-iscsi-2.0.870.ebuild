# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator linux-mod eutils flag-o-matic

DESCRIPTION="Open-iSCSI is a high performance, transport independent, multi-platform implementation of RFC3720"
HOMEPAGE="http://www.open-iscsi.org/"
MY_PV="${PN}-$(replace_version_separator 2 "-" $MY_PV)"
SRC_URI="http://www.open-iscsi.org/bits/${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~mips"
IUSE="modules utils debug"
DEPEND="virtual/libc
		virtual/linux-sources"
RDEPEND="${DEPEND}
		virtual/modutils
		sys-apps/util-linux"

S="${WORKDIR}/${MY_PV}"

MODULE_NAMES_ARG="kernel/drivers/scsi:${S}/kernel"
MODULE_NAMES="iscsi_tcp(${MODULE_NAMES_ARG}) scsi_transport_iscsi(${MODULE_NAMES_ARG}) libiscsi(${MODULE_NAMES_ARG})"
BUILD_TARGETS="all"
CONFIG_CHECK="CRYPTO_CRC32C"
ERROR_CFG="open-iscsi needs CRC32C support in your kernel."

src_unpack() {
	unpack ${A}
	export EPATCH_OPTS="-d${S}"
	if [ $KV_PATCH -lt 15 ]; then
		die "Sorry, your kernel must be 2.6.16-rc5 or newer!"
	fi
}

src_compile() {
	use debug && append-flags -DDEBUG_TCP -DDEBUG_SCSI

	if use modules; then
		einfo "Building kernel modules"
		export KSRC="${KERNEL_DIR}"
		linux-mod_src_compile || die "failed to build modules"
	fi

	einfo "Building fwparam_ibft"
	cd "${S}"/utils/fwparam_ibft && \
	CFLAGS="" emake OPTFLAGS="${CFLAGS}" \
		|| die "emake failed"

	einfo "Building userspace"
	cd "${S}"/usr && \
	CFLAGS="" emake OPTFLAGS="${CFLAGS}" \
		|| die "emake failed"

	if use utils; then
		einfo "Building utils"
		cd "${S}"/utils && \
		CFLAGS="" emake OPTFLAGS="${CFLAGS}" \
			|| die "emake failed"
	fi
}

src_install() {
	if use modules; then
		einfo "Installing kernel modules"
		export KSRC="${KERNEL_DIR}"
		linux-mod_src_install
	fi

	einfo "Installing userspace"
	dosbin usr/iscsid usr/iscsiadm usr/iscsistart

	if use utils; then
		einfo "Installing utilities"
		dosbin utils/iscsi-iname utils/iscsi_discovery
	fi

	einfo "Installing docs"
	doman doc/*[1-8]
	dodoc README THANKS
	docinto test
	dodoc test/*

	einfo "Installing configuration"
	insinto /etc/iscsi
	doins etc/iscsid.conf
	doins "${FILESDIR}"/initiatorname.iscsi
	insinto /etc/conf.d
	newins "${FILESDIR}"/iscsid-${PV}.conf.d iscsid
	newinitd "${FILESDIR}"/iscsid-${PV}.init.d iscsid

	keepdir /var/db/iscsi
	fperms 700 /var/db/iscsi
	fperms 600 /etc/iscsi/iscsid.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
