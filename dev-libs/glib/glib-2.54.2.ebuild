# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator multilib-minimal

MY_PV=$(get_version_component_range 1-2 $PV)
SRC_URI="http://download.gnome.org/sources/${PN}/${MY_PV}/${P}.tar.xz"

DESCRIPTION="The Glib library of C routines"
HOMEPAGE="https://www.gtk.org"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="~amd64"

#systemtap requires DTrace which is not available
IUSE="-test -doc -pcre -selinux xattr -systemtap -debug"

DEPEND="
	pcre? ( >=dev-libs/libpcre-8.41 )
	test? ( >=sys-apps/dbus-1.12.2 )
	doc? (
		>=dev-libs/elfutils-0.170
		>=app-text/docbook-xml-dtd-4.5
		>=app-text/docbook-xsl-stylesheets-1.79.1
		>=dev-libs/libxslt-1.1.32
	)
	xattr? ( sys-libs/glibc )
	systemtap? ( dev-util/systemtap )
	selinux? ( sys-libs/libselinux )
"

RDEPEND="
	${DEPEND}
	>=dev-libs/gobject-introspection-1.54.1
"
src_configure(){
	econf \
		"--with-pcre=$(usex pcre system internal)"\
		$(use_enable doc man)\
		$(use_enable doc gtk-doc)\
		$(use_enable xattr)\
		$(use_enable selinux)\
		$(use_enable systemtap dtrace)\
		$(use_enable systemtap)\
		"--enable-debug=$(usex debug yes minimal)"
}

multilib_src_configure() {
		
}
