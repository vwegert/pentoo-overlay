if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CXXFLAGS=${CXXFLAGS/-Os/-O3}; fi
