# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Transparent server-side session support for flask"
HOMEPAGE="https://pypi.org/project/Flask-KVSession/ https://github.com/mbr/flask-kvsession"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-python/flask-0.8[${PYTHON_USEDEP}]
	>=dev-python/simplekv-0.9.1[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-0.20[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
