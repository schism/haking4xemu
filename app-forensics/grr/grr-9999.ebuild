# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils git-r3

DESCRIPTION="GRR Rapid Response is an Incident Response Framework"
HOMEPAGE="http://code.google.com/p/grr/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/google/grr.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-forensics/sleuthkit-3.2.3
	app-forensics/pytsk
	>dev-python/django-1.4
	dev-python/ipython
	>dev-python/m2crypto-0.21.1
	>=dev-python/psutil-0.6
	dev-python/pymongo
	dev-python/python-dateutil
	dev-python/ipaddr
	app-arch/zip
	net-misc/wget
	dev-libs/protobuf
	dev-db/mongodb
	app-admin/apache-tools
	app-arch/deb2targz"
RDEPEND="${DEPEND}"

