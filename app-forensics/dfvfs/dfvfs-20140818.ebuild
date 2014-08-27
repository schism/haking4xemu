# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit versionator distutils-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Digital Forensics Virtual File System provides read-only access to file-system objects from various storage media types and file formats"
HOMEPAGE="https://code.google.com/p/dfvfs"
SRC_URI="https://googledrive.com/host/0B3fBvzttpiiSZTI3MWV6di1fRDg/${PN}-${MY_DATE}.tar.gz"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND="app-forensics/pytsk
		app-forensics/libewf[python]
		app-forensics/libqcow[python]
		app-forensics/libsmdev[python]
		app-forensics/libsmraw[python]
		app-forensics/libvhdi[python]
		app-forensics/libvmdk[python]
		app-forensics/libbde[python]
		app-forensics/libvshadow[python]"
RDEPEND="${DEPEND}"
