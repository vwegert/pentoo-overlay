# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 autotools

DESCRIPTION="Library to support cross-platform AES encryption"
HOMEPAGE="https://github.com/libyal/libcaes"
SRC_URI="https://github.com/libyal/libcaes/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 x86"
IUSE="nls python"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	dev-libs/openssl
	dev-libs/libcerror
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	python? ( dev-lang/python:* )
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"

src_prepare() {
	#upstream does not support its own shared libraries, let's fix that
	eapply -l "${FILESDIR}/${PN}"-autoconf_shared_libs.patch

	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable python) \
		$(use_enable python python3) \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)
		# \
		#--with-libcerror
}
