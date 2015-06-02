# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
#WANT_ANT_TASKS="ant-core ant-ivy ant-junit"

inherit java-pkg-opt-2 java-ant-2 git-r3 autotools-utils

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sleuthkit/sleuthkit"

LICENSE="GPL-2 IBM"
SLOT="0/10"
KEYWORDS="-*"
IUSE="aff ewf java"

DEPEND="dev-db/sqlite:3
	ewf? ( >=app-forensics/libewf-20120328 )
	aff? ( app-forensics/afflib )
	java? ( >=virtual/jdk-1.6 )
	sys-libs/zlib"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

DOCS=( NEWS.txt README.txt )

PATCHES=(
	"${FILESDIR}"/${PN}-4.1.0-system-sqlite.patch
	"${FILESDIR}"/${PN}-4.1.0-tools-shared-libs.patch
)

src_configure() {
	local myeconfargs=(
		$(use_with aff afflib)
		$(use_with ewf libewf)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use java; then
		cd bindings/java
		eant
	fi
}
