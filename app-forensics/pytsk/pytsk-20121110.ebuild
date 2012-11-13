# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python bindings for the Sleuthkit"
HOMEPAGE="http://code.google.com/p/pytsk/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-2012-11-10.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos ~x64-macos"
IUSE=""

DEPEND="app-forensics/sleuthkit"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
DOCUMENTS=( README LICENSE samples/* )
