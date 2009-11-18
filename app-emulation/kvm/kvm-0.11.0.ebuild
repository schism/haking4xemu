# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs linux-info

MY_PN="qemu-${PN}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"
PATCHSET="kvm-patches-20091111"

DESCRIPTION="Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.linux-kvm.org"
SRC_URI="mirror://sourceforge/kvm/${MY_P}.tar.gz
	http://dev.gentoo.org/~dang/files/${PATCHSET}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="alsa bios bluetooth curl esd gnutls +modules ncurses pulseaudio sasl +sdl vde"
RESTRICT="test"

RDEPEND="
	sys-libs/zlib
	sys-apps/pciutils
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	curl? ( net-misc/curl )
	esd? ( media-sound/esound )
	pulseaudio? ( media-sound/pulseaudio )
	gnutls? ( net-libs/gnutls )
	ncurses? ( sys-libs/ncurses )
	sasl? ( dev-libs/cyrus-sasl )
	sdl? ( >=media-libs/libsdl-1.2.11[X] )
	vde? ( net-misc/vde )
	bluetooth? ( net-wireless/bluez )
	modules? ( ~app-emulation/kvm-kmod-88 )"
#bios? (
	#sys-devel/dev86
	#dev-lang/perl
	#sys-power/iasl
#)

DEPEND="${RDEPEND}
		gnutls? ( dev-util/pkgconfig )
		app-text/texi2html"

QA_TEXTRELS="usr/bin/kvm"

pkg_setup() {
	if use modules ; then
		:;
	elif kernel_is lt 2 6 25; then
		eerror "This version of KVM requres a host kernel of 2.6.25 or higher."
		eerror "Either upgrade your kernel, or enable the 'modules' USE flag."
		die "kvm version not compatible"
	elif ! linux_chkconfig_present KVM; then
		eerror "Please enable KVM support in your kernel, found at:"
		eerror
		eerror "  Virtualization"
		eerror "    Kernel-based Virtual Machine (KVM) support"
		eerror
		eerror "or enable the 'modules' USE flag."
		die "KVM support not detected!"
	fi
}

src_prepare() {
	# avoid fdt till an updated release appears
	sed -i -e 's:fdt="yes":fdt="no":' configure
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Append CFLAGS while linking
	sed -i 's/$(LDFLAGS)/$(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS)/' rules.mak
	# avoid strip
	sed -i 's/$(INSTALL) -m 755 -s/$(INSTALL) -m 755/' \
		Makefile Makefile.target */Makefile
	EPATCH_SOURCE="${WORKDIR}/${PATCHSET}"
	EPATCH_SUFFIX="patch"
	epatch
}

src_configure() {
	local mycc conf_opts audio_opts

	conf_opts="--disable-darwin-user --disable-bsd-user"

	use curl || conf_opts="$conf_opts --disable-curl"
	use gnutls || conf_opts="$conf_opts --disable-vnc-tls"
	use ncurses || conf_opts="$conf_opts --disable-curses"
	use sasl || conf_opts="$conf_opts --disable-vnc-sasl"
	use sdl || conf_opts="$conf_opts --disable-sdl"
	use vde || conf_opts="$conf_opts --disable-vde"
	use bluetooth || conf_opts="$conf_opts --disable-bluez"

	audio_opts="oss"
	use alsa && audio_opts="alsa $audio_opts"
	use esd && audio_opts="esd $audio_opts"
	use pulseaudio && audio_opts="pa $audio_opts"
	use sdl && audio_opts="sdl $audio_opts"

	conf_opts="$conf_opts --prefix=/usr"
	conf_opts="$conf_opts --disable-strip"
	conf_opts="$conf_opts --disable-xen"

	filter-flags -fPIE
	filter-flags -fstack-protector #286587

	./configure ${conf_opts} \
		--audio-drv-list="$audio_opts" \
		--cc=$(tc-getCC) --host-cc=$(tc-getCC) \
		|| die "configure failed"
}

src_install() {
	# Fix docs manually (dynamically generated during compile)
	sed -i -e 's/QEMU/KVM/g;\
			s/qemu/kvm/g;\
			s/Qemu/Kvm/g;\
			s/kvm-\([a-z\-]*\)\.texi/qemu-\1\.texi/g' \
		*.texi *.1 *.8

	emake DESTDIR="${D}" install || die "make install failed"

	exeinto /etc/kvm
	newins kvm/scripts/qemu-ifup kvm-ifup || die
	newins kvm/scripts/qemu-ifdown kvm-ifdown || die 

	dobin "${S}/kvm/kvm_stat"

	mv "${D}"/usr/share/man/man1/qemu.1 "${D}"/usr/share/man/man1/kvm.1
	mv "${D}"/usr/share/man/man1/qemu-img.1 "${D}"/usr/share/man/man1/kvm-img.1
	mv "${D}"/usr/share/man/man8/qemu-nbd.8 "${D}"/usr/share/man/man8/kvm-nbd.8
	mv "${D}"/usr/bin/qemu-img "${D}"/usr/bin/kvm-img
	mv "${D}"/usr/bin/qemu-nbd "${D}"/usr/bin/kvm-nbd
	mv "${D}"/usr/bin/qemu-io "${D}"/usr/bin/kvm-io
	rm "${D}"/usr/share/kvm/openbios-{sparc32,sparc64,ppc}

	insinto /etc/udev/rules.d/
	doins kvm/scripts/65-kvm.rules || die

	dodoc pc-bios/README || die
	newdoc qemu-doc.html kvm-doc.html || die
	newdoc qemu-tech.html kvm-tech.html || die
}

pkg_preinst() {
	elog "Creating KVM group"
	enewgroup kvm
}

pkg_postinst() {
	elog "If you don't have kvm compiled into the kernel, make sure you have"
	elog "the kernel module loaded before running kvm. The easiest way to"
	elog "ensure that the kernel module is loaded is to load it on boot."
	elog "For AMD CPUs the module is called 'kvm-amd'"
	elog "For Intel CPUs the module is called 'kvm-intel'"
	elog "Please review /etc/conf.d/modules for how to load these"
	elog
	elog "Make sure your user is in the 'kvm' group"
	elog "Just run 'gpasswd -a <USER> kvm', then have <USER> re-login."
	elog
	elog "You will need the Universal TUN/TAP driver compiled into your"
	elog "kernel or loaded as a module to use the virtual network device"
	elog "if using -net tap.  You will also need support for 802.1d"
	elog "Ethernet Bridging and a configured bridge if using the provided"
	elog "kvm-ifup script from /etc/kvm."
	echo
}
