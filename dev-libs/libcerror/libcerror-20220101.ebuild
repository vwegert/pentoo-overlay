# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library for cross-platform C error functions"
HOMEPAGE="https://github.com/libyal/libcerror"
SRC_URI="https://github.com/libyal/libcerror/releases/download/${PV}/${PN}-beta-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls"

DEPEND="nls? ( virtual/libiconv
	virtual/libintl )"
RDEPEND="${DEPEND}"

#  --disable-rpath         do not hardcode runtime library paths
src_configure() {
	econf $(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix)
}
