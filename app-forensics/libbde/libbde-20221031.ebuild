# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit python-single-r1 autotools

DESCRIPTION="Library and tools to access BitLocker Drive Encryption (BDE) encrypted volumes."
HOMEPAGE="https://github.com/libyal/libbde"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug python nls unicode"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="nls? ( virtual/libintl
		virtual/libiconv
	)
	python? ( dev-lang/python:* )
	sys-fs/fuse:*

	app-forensics/libbfio

	>=dev-libs/libcdata-20190112
	dev-libs/libcerror
	dev-libs/libcfile
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcpath
	dev-libs/libcsplit
	dev-libs/libcthreads
	dev-libs/libfcache
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libfvalue
	dev-libs/libuna
"

RDEPEND="${DEPEND}
	python? ( ${PYTHON_DEPS} )
	sys-fs/fuse"

src_prepare() {
	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable python) \
		$(use_enable python python3) \
		$(use_enable unicode wide-character-type) \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
}
