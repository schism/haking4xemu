# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="File carver with plugin validators"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~x86-macos ~x64-macos"
IUSE="java +plugins python"
REQUIRED_USE="plugins? ( || ( java python ) )"

DEPEND="dev-libs/openssl
	>=app-forensics/sleuthkit-3.0
	app-forensics/afflib
	app-forensics/libewf
	sys-apps/file
	dev-libs/openssl
	java? ( >=virtual/jdk-1.5 )
	python? ( dev-lang/python )"

src_compile() {
	default
	if use java; then
		emake -C plugins plugins.jar
	fi
}

src_install() {
	default
	rm ${D}/usr/bin/test_arff

	if use plugins; then
		sed -i -e "s:\.\./plugins/:${EROOT}/usr/libexec/fiwalk/:g" plugins/ficonfig.txt
		insinto /etc
		doins plugins/ficonfig.txt
	fi

	if use python; then
		dodir /usr/libexec/fiwalk
		insinto /usr/libexec/fiwalk
		doins plugins/*.py
	fi

	if use java; then
		dodir /usr/libexec/fiwalk
		insinto /usr/libexec/fiwalk
		doins plugins/plugins.jar
	fi
}
