# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-API2/PDF-API2-0.65.ebuild,v 1.3 2009/07/19 17:42:57 tove Exp $

inherit perl-module

DESCRIPTION="A Perl Module Chain to faciliate the Creation and Modification of High-Quality \"Portable Document Format (aka. PDF)\" Files"
SRC_URI="mirror://cpan/authors/id/A/AR/AREIBENS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~areibens/"

SLOT="0"
LICENSE="|| ( Artistic LGPL-2 )"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-IO-Compress
		dev-lang/perl"
