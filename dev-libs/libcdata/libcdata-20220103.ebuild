# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for cross-platform C generic data functions"
HOMEPAGE="https://github.com/libyal/libcdata"
SRC_URI="https://github.com/libyal/libcdata/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls"

DEPEND="
	dev-libs/libcerror
	dev-libs/libcthreads
	nls? (
		virtual/libiconv
		virtual/libintl
	)
"

src_prepare() {
	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)
}
