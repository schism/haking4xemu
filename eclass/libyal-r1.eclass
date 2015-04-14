# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: schism $

# @ECLASS: libyal-r1.eclass
# @MAINTAINER:
# schism@subverted.org
# @AUTHOR:
# Original Author: schism <schism@subverted.org>
# @BLURB: Generalize the common functions and needs of the libyal-r1 constellation # of applications.
# @DESCRIPTION:
# Automates much of the labor of updating the dozens of package libyal-r1 provides.

# pre-inheritance eclass variables
# @ECLASS-VARIABLE: LIBYAL_RELEASE
# @DESCRIPTION: What release level (experimental, testing, alpha, beta, etc.) this is deemed, defaults to "alpha"
# @DEFAULT_UNSET
# @ECLASS-VARIABLE: LIBYAL_PYLIB
# @DESCRIPTION: The name of the Python bindings this library may create (e.g. pyexe for libexe)
# @DEFAULT_UNSET

inherit eutils versionator autotools-utils

LIBYAL_DATE="$(get_version_component_range 1)"
SRC_URI="${HOMEPAGE}/releases/download/${LIBYAL_DATE}/${PN}-${LIBYAL_RELEASE:=alpha}-${LIBYAL_DATE}.tar.gz"

if [[ ${PV} == 9999* ]] ; then
	AUTOTOOLS_AUTORECONF=1
	EGIT_REPO_URI="${HOMEPAGE}"
	${KEYWORDS:=-*}
	inherit git-r3
fi

if [ ! -z ${LIBYAL_PYLIB} ]; then
	PYTHON_COMPAT=( python2_7 )
	inherit python-single-r1
	REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
fi

# these tools don't hnad split builds very gracefully
AUTOTOOLS_IN_SOURCE_BUILD=1

# post-inheritance eclass variables
# @ECLASS-VARIABLE: LIBYAL_IUSE
# @DESCRIPTION: Offers the standard basic IUSE for libyal-r1
LIBYAL_IUSE="debug iconv nls python static static-libs threads unicode"
# @ECLASS-VARIABLE: LIBYAL_DEPEND
# @DESCRIPTION: Offers the standard basic DEPEND for libyal-r1
LIBYAL_DEPEND="iconv? ( virtual/libiconv )
	nls? ( virtual/libintl )
	python? ( ${PYTHON_DEPS} )"

EXPORT_FUNCTIONS pkg_setup src_configure src_compile src_install

# @FUNCTION: libyal-r1_pkg_setup
# @DESCRIPTION:
# the pkg_setup function to call the appropriate python package setup if needed
libyal-r1_pkg_setup() {
	in_iuse python && use python && python-single-r1_pkg_setup
}

# @FUNCTION: libyal-r1_src_configure
# @DESCRIPTION:
# The src_configure function for most normal libyal-r1 packages.  Configuration
# parameters are passed in libyal-r1_econf if they are out of the norm (e.g.
# libewf's --enable-v1-api) for libyal-r1 packages.  As with autotools-utils (from
# which we inherit), the libyal-r1_econf is a bash array and may be used the same
# way. We by default handle the following: 
#	IUSE="debug fuse iconv nls python static static-libs threads unicode"

# @VARIABLE: libyal-r1_econf
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional econf arguments as Bash array. Should be defined before calling src_configure.
# @CODE
# src_configure() {
# 	local libyal-r1_econf=(
# 		--disable-readline
# 		--with-confdir="/etc/nasty foo confdir/"
# 		$(use_enable debug cnddebug)
# 		$(use_enable threads multithreading)
# 	)
# 	libyal-r1_src_configure
# }
# @CODE
libyal-r1_src_configure() {
	# common default, present in every libyal-r1 package
	local myeconfargs=(
		$(use_enable unicode wide-character-type)
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
	)

	if in_iuse python; then
		myeconfargs+=($(use_enable python))
	fi

	if in_iuse static; then
		myeconfargs+=($(use_enable static static-executables))
	fi

	if in_iuse nls; then
		myeconfargs+=($(use_enable nls))
		myeconfargs+=($(use_with nls libintl-prefix))
	fi

	if in_iuse threads; then
		myeconfargs+=($(use_enable threads multi-threading-support))
	fi

	if in_iuse iconv; then
		myeconfargs+=($(use_with iconv libiconv-prefix))
	fi

	if in_iuse fuse; then
		myeconfargs+=($(use_with fuse libfuse))
	fi

	# add any custom econf args for the ebuild
	myeconfargs+=(${libyal_econf[@]})

	autotools-utils_src_configure
}

# @FUNCTION: libyal-r1_src_compile
# @DESCRIPTION:
# The src_compile function for most normal libyal-r1 packages.  Mostly just hands
# off to autotools-utils and handles python appropriately
libyal-r1_src_compile() {
	autotools-utils_src_compile
	if in_iuse python && use python; then
		emake -C ${LIBYAL_PYLIB}
	fi
}

# @FUNCTION: libyal-r1_src_install
# @DESCRIPTION:
# The src_install function for most normal libyal-r1 packages.  Mostly just hands
# off to autotools-utils and handles python appropriately
libyal-r1_src_install() {
	autotools-utils_src_install
	if in_iuse python && use python; then
		emake -C ${LIBYAL_PYLIB} DESTDIR="${D}" install
	fi
}
