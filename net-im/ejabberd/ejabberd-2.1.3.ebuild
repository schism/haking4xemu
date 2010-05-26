# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils multilib pam ssl-cert

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://www.ejabberd.im/"
SRC_URI="http://www.process-one.net/downloads/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~x86 ~x64-macos ~x86-macos"
EJABBERD_MODULES="mod_irc mod_muc mod_proxy65 mod_pubsub mod_statsdx"
IUSE="captcha debug ldap odbc pam ssl +web zlib ${EJABBERD_MODULES}"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/expat-1.95
	>=dev-lang/erlang-12.2.5[ssl?]
	odbc? ( dev-db/unixODBC )
	ldap? ( =net-nds/openldap-2* )
	ssl? ( >=dev-libs/openssl-0.9.8e )
	captcha? ( media-gfx/imagemagick[truetype,png] )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	>=sys-apps/shadow-4.1.4.2-r2"

#>=sys-apps/shadow-4.1.4.2-r2 - fixes bug in su that made ejabberdctl unworkable.

PROVIDE="virtual/jabber-server"

S=${WORKDIR}/${P}/src

# pathes in net-im/jabber-base
JABBER_ETC="/etc/jabber"
#JABBER_RUN="/var/run/jabber"
JABBER_SPOOL="/var/spool/jabber"
JABBER_LOG="/var/log/jabber"
JABBER_DOC="/usr/share/doc/${PF}"

src_prepare() {
	if use mod_statsdx; then
		ewarn "mod_statsdx is not a part of upstream tarball but is a third-party module"
		ewarn "taken from here: http://www.ejabberd.im/mod_stats2file"
		epatch "${FILESDIR}/2.1.1-mod_statsdx.patch"
	fi

	# don't install release notes (we'll do this manually)
	sed '/install .* [.][.]\/doc\/[*][.]txt $(DOCDIR)/d' -i Makefile.in || die
	# Set correct pathes
	sed -e "/^EJABBERDDIR[[:space:]]*=/{s:ejabberd:${PF}:}" \
		-e "/^ETCDIR[[:space:]]*=/{s:@sysconfdir@/ejabberd:${JABBER_ETC}:}" \
		-e "/^LOGDIR[[:space:]]*=/{s:@localstatedir@/log/ejabberd:${JABBER_LOG}:}" \
		-e "/^SPOOLDIR[[:space:]]*=/{s:@localstatedir@/lib/ejabberd:${JABBER_SPOOL}:}" \
			-i Makefile.in || die
	sed -e "/EJABBERDDIR=/{s:ejabberd:${PF}:}" \
		-e "s|\(ETCDIR=\)@SYSCONFDIR@.*|\1${JABBER_ETC}|" \
		-e "s|\(LOGS_DIR=\)@LOCALSTATEDIR@.*|\1${JABBER_LOG}|" \
		-e "s|\(SPOOLDIR=\)@LOCALSTATEDIR@.*|\1${JABBER_SPOOL}|" \
			-i ejabberdctl.template || die

	# Set shell, so it'll work even in case jabber user have no shell
	# This is gentoo specific I guess since other distributions may have
	# ejabberd user with reall shell, while we share this user among different
	# jabberd implementations.
	sed '/^HOME/aSHELL=/bin/sh' -i ejabberdctl.template || die
	sed '/^export HOME/aexport SHELL' -i ejabberdctl.template || die

	#sed -e "s:/share/doc/ejabberd/:${JABBER_DOC}:" -i web/ejabberd_web_admin.erl

	# fix up the ssl cert paths in ejabberd.cfg to use our cert
	sed -e "s:/path/to/ssl.pem:/etc/ssl/ejabberd/server.pem:g" \
		-i ejabberd.cfg.example || die "Failed sed ejabberd.cfg.example"

	# correct path to captcha script in default ejabberd.cfg
	sed -e 's|\({captcha_cmd,[[:space:]]*"\).\+"}|\1/usr/'$(get_libdir)'/erlang/lib/'${P}'/priv/bin/captcha.sh"}|' \
			-i ejabberd.cfg.example || die "Failed sed ejabberd.cfg.example"

	# disable mod_irc
	if ! use mod_irc; then
		sed -i -e "s/{mod_irc,/%{mod_irc,/" \
			-i ejabberd.cfg.example || die "Failed to disable mod_irc"
	fi
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--libdir="${EPREFIX}/usr/$(get_libdir)/erlang/lib/" \
		$(use_enable mod_irc) \
		$(use_enable ldap eldap) \
		$(use_enable mod_muc) \
		$(use_enable mod_proxy65) \
		$(use_enable mod_pubsub) \
		$(use_enable ssl tls) \
		$(use_enable web) \
		$(use_enable odbc) \
		$(use_enable zlib ejabberd_zlib) \
		$(use_enable pam) \
		--enable-user=jabber
}

src_compile() {
	emake $(use debug && echo debug=true ejabberd_debug=true) || die "compiling ejabberd core failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "install failed"

	# Pam helper module permissions
	# http://www.process-one.net/docs/ejabberd/guide_en.html
	if use pam; then
		pamd_mimic_system xmpp auth account || die "Cannot create pam.d file"
		fperms 4750 "/usr/$(get_libdir)/erlang/lib/${P}/priv/bin/epam" || die "Cannot adjust epam permissions"
	fi

	cd "${WORKDIR}/${P}/doc"
	dodoc "release_notes_${PV%%_rc*}.txt" || die

	#dodir /var/lib/ejabberd
	newinitd "${FILESDIR}/${PN}-3.initd" ${PN} || die "Cannot install init.d script"
	newconfd "${FILESDIR}/${PN}-3.confd" ${PN} || die "Cannot install conf.d file"
}

pkg_postinst() {
	elog "For configuration instructions, please see"
	elog "/usr/share/doc/${PF}/html/guide.html, or the online version at"
	elog "http://www.process-one.net/en/projects/ejabberd/docs/guide_en.html"

	if ! use web ; then
		elog
		ewarn "The web USE flag is off, this has disabled the web admin interface."
		elog
	fi

	elog
	elog '===================================================================='
	elog 'Quick Start Guide:'
	elog '1) Add output of `hostname -f` to /etc/jabber/ejabberd.cfg line 89'
	elog '   {hosts, ["localhost", "thehost"]}.'
	elog '2) Add an admin user to /etc/jabber/ejabberd.cfg line 324'
	elog '   {acl, admin, {user, "theadmin", "thehost"}}.'
	elog '3) Start the server'
	elog '   # /etc/init.d/ejabberd start'
	elog '4) Register the admin user'
	elog '   # /usr/sbin/ejabberdctl register theadmin thehost thepassword'
	elog '5) Log in with your favourite jabber client or using the web admin'

	# Upgrading from ejabberd-2.0.x:
	# 1. To keep ejabberd bootable we need to move EJABBERD_NODE from
	# /etc/conf.d/ejebberd into ERLANG_NODE inside /etc/jabberd/ejabberdctl.cfg
	# /etc/conf.d/ejabberd is handled by PM but everything else is our job
	# 2. Copy cookie
	# 3. Copy ssl certificate
	if grep -E '^[^#]*EJABBERD_NODE=' "${EROOT}/etc/conf.d/ejabberd" >/dev/null 2>&1; then
		source "${EROOT}/etc/conf.d/ejabberd"
		ewarn
		ewarn "!!! WARNING !!!  WARNING !!!  WARNING !!!  WARNING !!!"
		ewarn "Starting with 2.1.x some pathes and configuration files were"
		ewarn "changed to better reflect upstream intentions. Notable changes are:"
		ewarn
		ewarn "1. Everything (even init scripts) are now handled by ejabberdctl script."
		ewarn "Thus main configuration file became /etc/jabberd/ejabberdctl.cfg"
		ewarn "You must update ERLANG_NODE there with the value of EJABBERD_NODE"
		ewarn "from /etc/conf.d/ejebberd or ejabberd will refuse to start."
		ewarn
		ewarn "2. SSL certificate is now generated with ssl-cert eclass and resides"
		ewarn "at standard location: /etc/ssl/ejabberd/server.pem."
		ewarn
		ewarn "3. Cookie now resides at /var/spool/jabber/.erlang.cookie"
		ewarn
		ewarn "We'll try to handle upgrade automagically but, please, do your"
		ewarn "own checks and do not forget to run 'etc-update'!"

		local i ctlcfg new_ctlcfg
		i=0
		ctlcfg=${EROOT}/etc/jabber/ejabberdctl.cfg
		while :; do
			new_ctlcfg=$(printf "${EROOT}/etc/jabber/._cfg%04d_ejabberdctl.cfg" ${i})
			[[ ! -e ${new_ctlcfg} ]] && break
			ctlcfg=${new_ctlcfg}
			((i++))
		done

		ewarn
		ewarn "Updating ${ctlcfg} (debug: ${new_ctlcfg})"
		sed -e "/#ERLANG_NODE=/aERLANG_NODE=$EJABBERD_NODE" "${ctlcfg}" > "${new_ctlcfg}" || die
		
		if [[ -e ${EROOT}/var/run/jabber/.erlang.cookie ]]; then
			einfo "Moving .erlang.cookie..."
			if [[ -e ${EROOT}/var/spool/jabber/.erlang.cookie ]]; then
				mv -v "${EROOT}"/var/spool/jabber/.erlang.cookie{,bak}
			fi
			mv -v "${EROOT}"/var/{run/jabber,spool/jabber}/.erlang.cookie
		fi
	fi

	if use ssl; then
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Ejabberd XMPP Server}"
		if [[ -e ${EROOT}/etc/jabber/ssl.pem ]]; then
			einfo "Moving SSL certificate to new location..."
			mkdir -p "${EROOT}/etc/ssl/ejabberd/"
			mv -v "${EROOT}/etc/jabber/ssl.pem" "${EROOT}/etc/ssl/ejabberd/server.pem"
		fi
		install_cert /etc/ssl/ejabberd/server
	fi
}
