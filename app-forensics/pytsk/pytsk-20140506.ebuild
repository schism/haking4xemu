# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit versionator autotools-utils distutils-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Python bindings for the Sleuthkit"
HOMEPAGE="http://code.google.com/p/pytsk/"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiScUxsUm54cG02RDA/${PN}-${MY_DATE}.tgz"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos ~x64-macos"
IUSE=""

DEPEND="app-forensics/sleuthkit"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

