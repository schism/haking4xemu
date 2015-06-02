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

# these tools don't handle split builds very gracefully
AUTOTOOLS_IN_SOURCE_BUILD=1

if [[ ${PV} == 9999* ]] ; then
	AUTOTOOLS_AUTORECONF=1
	EGIT_REPO_URI="https://github.com/libyal/${PN}/"
	inherit git-r3
fi

if [ ! -z ${LIBYAL_PYLIB} ]; then
	PYTHON_COMPAT=( python2_7 )
	inherit python-single-r1
	REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
	_LIBYAL_PYUSE="python? ( ${PYTHON_DEPS} )"
fi

inherit eutils versionator autotools-utils

# don't set src_uri if this is a git build
if [ -z ${EGIT_REPO_URI} ]; then
	LIBYAL_DATE="$(get_version_component_range 1)"
	SRC_URI="https://github.com/libyal/${PN}/releases/download/${LIBYAL_DATE}/${PN}-${LIBYAL_RELEASE:=alpha}-${LIBYAL_DATE}.tar.gz"
fi

# post-inheritance eclass variables
# @ECLASS-VARIABLE: LIBYAL_IUSE
# @DESCRIPTION: Offers the standard basic IUSE for libyal-r1
LIBYAL_IUSE="debug iconv nls static static-libs threads unicode"
if [ ! -z ${LIBYAL_PYLIB} ]; then
	LIBYAL_IUSE="${LIBYAL_IUSE} python"
fi
# @ECLASS-VARIABLE: LIBYAL_DEPEND
# @DESCRIPTION:
# Offers the basic DEPEND for libyal-r1 (presumes IUSE='iconv nls python',
# python optional)
LIBYAL_DEPEND="${_LIBYAL_PYUSE}
	iconv? ( virtual/libiconv )
	nls? ( virtual/libintl )"

EXPORT_FUNCTIONS pkg_setup src_prepare src_configure src_compile src_install

# @FUNCTION: libyal-r1_pkg_setup
# @DESCRIPTION:
# the pkg_setup function to call the appropriate python package setup if needed
libyal-r1_pkg_setup() {
	in_iuse python && use python && python-single-r1_pkg_setup
}

# @FUNCTION: libyal-r1_src_prepare
# @DESCRIPTION:
# If the ebuild is a live (git) ebuild, runs the appropriate script to pull in
# the dependency libraries so build will succeed (whether or not they're used).
libyal-r1_src_prepare() {
	if [ ! -z ${EGIT_REPO_URI} ]; then
		sh "${S}/synclibs.sh"
	fi
	autotools-utils_src_prepare
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
	# for autotools-utils
	declare -a myeconfargs

	if in_iuse unicode; then
		myeconfargs+=($(use_enable unicode wide-character-type))
	fi
	
	if in_iuse debug; then
		myeconfargs+=(
			$(use_enable debug debug-output)
			$(use_enable debug verbose-output))
	fi

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
