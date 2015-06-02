# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="https://github.com/libyal/libewf/"
LIBYAL_RELEASE="experimental"
LIBYAL_PYLIB="pyewf"

inherit libyal-r1

LICENSE="LGPL-3"
SLOT="0/2"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="${LIBYAL_IUSE} ewf fuse ssl uuid zlib bzip2"

DEPEND="${LIBYAL_DEPEND}
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	bzip2? ( app-arch/bzip2 )
	dev-libs/libuna
	app-forensics/libbfio
	app-forensics/libodraw
	app-forensics/libsmdev
	app-forensics/libsmraw"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )


src_configure() {
	local libyal_econf=(
		$(use_enable ewf v1-api)
		$(use_with zlib)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
	)
	libyal-r1_src_configure
}
