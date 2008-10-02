# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Network protocol weakness analyzer"
HOMEPAGE="http://www.immunitysec.com"
SRC_URI="${HOMEPAGE}/downloads/SPIKE${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-libs/openssl"
RDEPEND=${DEPEND}

S="${WORKDIR}/SPIKE/SPIKE"
WANT_AUTOMAKE=1.6

src_unpack() {
	unpack "${A}"
	cd "${S}/src"
	eautoreconf
}

src_compile() {
	cd "${S}/src"
	econf
	emake
	cd "${S}/dcedump"
	emake
}

src_install() {
	# The spike environment is rather untidy with dangling bits of documentation
	# and inconsistent locations for everything else.  It doesn't even have an
	# install routine in spite of using autoconf, and most users would seem to
	# simply run the executables from the local directory.  This install tries
	# to cover all bases, but will likely miss some edge cases.
	cd "${S}"
	dolib src/libdlrpc.so
	dobin dcedump/ifids \
		dcedump/dcedump \
		src/citrix \
		src/closed_source_web_server_fuzz \
		src/dceoversmb \
		src/dltest \
		src/do_post \
		src/generic_chunked \
		src/generic_listen_tcp \
		src/generic_send_tcp \
		src/generic_send_udp \
		src/generic_web_server_fuzz \
		src/generic_web_server_fuzz2 \
		src/gopherd \
		src/halflife \
		src/line_send_tcp \
		src/msrpcfuzz \
		src/msrpcfuzz_udp \
		src/ntlm2 \
		src/ntlm_brute \
		src/pmspike \
		src/post_fuzz \
		src/post_spike \
		src/quake \
		src/quakeserver \
		src/sendmsrpc \
		src/ss_spike \
		src/statd_spike \
		src/sunrpcfuzz \
		src/webfuzz \
		src/x11_spike

	dodoc src/AUTHORS \
		src/LICENSES.txt \
		src/DUGSONGLICENSE.txt \
		src/README* \
		src/WEBFUZZING.txt \
		documentation/* \
		README.txt \
		CHANGELOG.txt \
		using_the_spike_api.txt

	newdoc dcedump/README README.dcedump
	newdoc dcedump/CHANGELOG CHANGELOG.dcedump

	rm src/ld.sh
	insinto "/usr/share/${PN}/scripts"
	doins src/*.py \
		src/*.sh \
		src/*.pl \
		src/*.spk
	# why won't doins handle recursive directories?
	cp -Rf src/audits "${D}/usr/share/${PN}/"
}
