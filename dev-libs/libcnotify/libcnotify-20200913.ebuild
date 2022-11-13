# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for cross-platform C notification functions"
HOMEPAGE="https://github.com/libyal/libcnotify"
SRC_URI="https://github.com/libyal/libcnotify/releases/download/${PV}/${PN}-beta-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 x86"
IUSE="nls"

DEPEND="
	dev-libs/libcerror
	nls? (
		virtual/libiconv
		virtual/libintl
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	#upstream does not support its own shared libraries, let's fix that
	eapply -l "${FILESDIR}/${PN}"-autoconf_shared_libs.patch

	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)
#		 \
#		--with-libcerror
}
