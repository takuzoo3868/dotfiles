#!/bin/sh

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`

GetVersionFromFile() {
	VERSION="$(tr "\n" ' ' < cat "$1" | sed s/.*VERSION.*=\ // )"
}


if [ "${OS}" = "SunOS" ] ; then
	OS=Solaris
	ARCH=$(uname -p)
	OSSTR="${OS} ${REV}(${ARCH} $(uname -v)"
  echo ${OSSTR}
  return

elif [ "${OS}" = "AIX" ] ; then
	OSSTR="${OS} $(oslevel) ($(oslevel -r)"
  echo ${OSSTR}
  return

elif [ "${OS}" = "Linux" ] ; then
	KERNEL=$(uname -r)
	if [ -f /etc/redhat-release ] ; then
		DIST='RedHat'
		PSUEDONAME=$(sed s/.*\(// < /etc/redhat-release | sed s/\)//)
		REV=$(sed s/.*release\ // < /etc/redhat-release | sed s/\ .*//)
	elif [ -f /etc/SuSE-release ] ; then
		DIST=$(tr "\n" ' ' < /etc/SuSE-release | sed s/VERSION.*//)
		REV=$(tr "\n" ' ' < /etc/SuSE-release| sed s/.*=\ //)
	elif [ -f /etc/mandrake-release ] ; then
		DIST='Mandrake'
		PSUEDONAME=$(sed s/.*\(// < /etc/mandrake-release | sed s/\)//)
		REV=$(sed s/.*release\ // < /etc/mandrake-release | sed s/\ .*//)
	elif [ -f /etc/debian_version ] ; then	
		if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
			DIST="Ubuntu"
		else
			DIST="Debian $(cat /etc/debian_version)"
			REV=""
		fi
	elif [ -f /etc/arch-release ] ; then
		DIST="Arch"
	fi
	if [ -f /etc/UnitedLinux-release ] ; then
		DIST="${DIST}[$(tr "\n" ' ' < /etc/UnitedLinux-release | sed s/VERSION.*//)]"
	fi
	OSSTR="${OS} ${DIST} ${REV}(${PSUEDONAME} ${KERNEL} ${MACH})"
  echo ${OSSTR}
  return

elif [ "${OS}" == "Darwin" ]; then
  type -p sw_vers &>/dev/null
  [ $? -eq 0 ] && {
    OS=`sw_vers | grep 'ProductName' | cut -f 2`
    VER=`sw_vers | grep 'ProductVersion' | cut -f 2`
    BUILD=`sw_vers | grep 'BuildVersion' | cut -f 2`
    OSSTR="Darwin ${OS} ${VER} ${BUILD}"
  } || {
    OSSTR="MacOSX"
  }
  echo ${OSSTR}
  return

fi

echo "Your platform ($(uname -a)) is not supported."
exit 1
