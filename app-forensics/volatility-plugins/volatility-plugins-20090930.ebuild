# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Meta-package for all the Volatility plugins"
HOMEPAGE="http://github.org/schism/haking4xemu"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-forensics/volatility-driverscan
	app-forensics/volatility-fileobjscan
	app-forensics/volatility-intrscan
	app-forensics/volatility-mhl
	app-forensics/volatility-misc
	app-forensics/volatility-moyix
	app-forensics/volatility-mutantscan
	app-forensics/volatility-objtypescan
	app-forensics/volatility-symlinkobjscan
	app-forensics/volatility-volreg
	"
RDEPEND="${DEPEND}"
