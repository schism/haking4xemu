# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${P/_beta/b}

DESCRIPTION="A graphical interface to the digital forensic analysis tools in The Sleuth Kit."
HOMEPAGE="http://www.sleuthkit.org/autopsy/"
SRC_URI="http://sleuthkit.org/betas/${MY_P}.tar.gz"
#SRC_URI="mirror://sourceforge/sleuthkit/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${MY_P}"

# Runtime depend on grep and file deliberate
RDEPEND=">=dev-lang/perl-5.8.0
	>=app-forensics/sleuthkit-3.0.0
	sys-apps/grep
	sys-apps/file"
DEPEND=""

src_unpack() {
	unpack "${A}"
	cd "${S}"

	echo "#!/usr/bin/perl -wT" > autopsy
	echo "use lib '/usr/lib/autopsy/';" >> autopsy
	echo "use lib '/usr/lib/autopsy/lib/';" >> autopsy
	cat base/autopsy.base >> autopsy
	sed -i 's:conf.pl:/etc/autopsy.pl:' README.txt \
		autopsy \
		help/hash_db.html \
		lib/Main.pm man/man1/autopsy.1
}

src_compile() {
	./configure << EOF
n
n
/tmp
EOF
	sed -i "s:INSTALLDIR = .*:INSTALLDIR = \'/usr/lib/autopsy\';:" conf.pl
}

src_install() {
	insinto /usr/lib/autopsy
	doins autopsy
	doins global.css
	insinto /usr/lib/autopsy/help
	doins help/*
	insinto /usr/lib/autopsy/lib
	doins lib/*
	insinto /usr/lib/autopsy/pict
	doins pict/*
	insinto /etc
	newins conf.pl autopsy.pl

	dodir /usr/bin
	dosym /usr/lib/autopsy/autopsy /usr/bin/autopsy
	fperms +x /usr/lib/autopsy/autopsy

	doman man/man1/autopsy.1
	dodoc CHANGES.txt README.txt TODO.txt docs/sleuthkit-informer-13.txt
}
