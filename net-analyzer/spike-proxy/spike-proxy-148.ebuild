# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Web application analysis tool"
HOMEPAGE="http://www.immunitysec.com/resources-freesoftware.shtml"
SRC_URI="${HOMEPAGE}/downloads/SP${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-libs/openssl
		dev-lang/python"
RDEPEND=${DEPEND}
