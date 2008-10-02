# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P=${P/v/V}
MY_P="${MY_P}_Beta"
DESCRIPTION="Win32 memory dissection framework"
HOMEPAGE="https://www.volatilesystems.com/default/volatility"
SRC_URI="https://www.volatilesystems.com/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
