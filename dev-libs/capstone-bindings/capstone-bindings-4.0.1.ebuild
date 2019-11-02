# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV//_/-}"
MY_P=capstone-"${MY_PV}"

DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit eutils multilib distutils-r1

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
#TODO: add java, ocaml, PowerShell, VB6, C#, Go, Ruby, NodeJS, C++ & Vala
IUSE="+python cython"

RDEPEND="python? ( ${PYTHON_DEPS} )
	cython? ( dev-python/cython )"
DEPEND="${RDEPEND}
	dev-libs/capstone
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${MY_P}/bindings/python

python_prepare() {
	#our hack to adjust cython setup
	if use cython; then
		einfo "cython flag is enabled"
		cp setup_cython.py setup.py
		sed -e "s|'xcore_const']|'xcore_const', 'tms320c64x', 'tms320c64x_const']|" -i setup.py || die "sed failed"
#		sed -e 's|install:|install_default:|' -i Makefile || die "sed failed"
#		sed -e 's|install_cython:|install:|' -i Makefile || die "sed failed"
		#this section is from Makefile
		cp capstone/__init__.py pyx/__init__.py
		for i in arm{,_const} arm64{,_const} mips{,_const} ppc{,_const} x86{,_const} sparc{,_const} systemz sysz_const xcore{,_const} tms320c64x{,_const}; do
			cp capstone/${i}.py pyx/${i}.pyx
		done
	fi
}
