#!/bin/sh 
###############################################################################################
# Description: This will install Goofys
# Author: Peter Winter
# Date: 12/01/2017
###############################################################################################
# License Agreement:
# This file is part of The Agile Deployment Toolkit.
# The Agile Deployment Toolkit is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# The Agile Deployment Toolkit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with The Agile Deployment Toolkit.  If not, see <http://www.gnu.org/licenses/>.
################################################################################################
################################################################################################

if ( [ "${1}" != "" ] )
then
	buildos="${1}"
fi

if ( [ "${buildos}" = "ubuntu" ] )
then
	if ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTOREMOUNTTOOL:goof:binary'`" = "1" ] )
	then
		/usr/bin/wget https://github.com/kahing/goofys/releases/latest/download/goofys			#####UBUNTU-GOOFYS-BINARY#####
		/bin/mv goofys /usr/bin										#####UBUNTU-GOOFYS-BINARY#####
		/bin/chmod 755 /usr/bin/goofys									#####UBUNTU-GOOFYS-BINARY#####
	elif ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTOREMOUNTTOOL:goof:source'`" = "1" ] )
	then
		${HOME}/installscripts/InstallGo.sh ${buildos}							
		DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -o DPkg::Lock::Timeout=-1  -qq -y install make	#####UBUNTU-GOOFYS-SOURCE#####
		/usr/bin/git clone https://github.com/kahing/goofys.git						#####UBUNTU-GOOFYS-SOURCE#####
		cd goofys											#####UBUNTU-GOOFYS-SOURCE#####
		make install											#####UBUNTU-GOOFYS-SOURCE#####
		goofys="`/usr/bin/find / -type f -name "goofys" -print`"					#####UBUNTU-GOOFYS-SOURCE#####
		/bin/mv ${goofys} /usr/bin									#####UBUNTU-GOOFYS-SOURCE-SKIP#####
		/bin/chmod 755 /usr/bin/goofys									#####UBUNTU-GOOFYS-SOURCE#####
		cd ..												#####UBUNTU-GOOFYS-SOURCE#####
		rm -r ./goofys											#####UBUNTU-GOOFYS-SOURCE#####
	fi
fi

if ( [ "${buildos}" = "debian" ] )
then
	if ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTOREMOUNTTOOL:goof:binary'`" = "1" ] )
	then
		/usr/bin/wget https://github.com/kahing/goofys/releases/latest/download/goofys			#####DEBIAN-GOOFYS-BINARY#####
		/bin/mv goofys /usr/bin										#####DEBIAN-GOOFYS-BINARY#####
		/bin/chmod 755 /usr/bin/goofys									#####DEBIAN-GOOFYS-BINARY#####
	elif ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTOREMOUNTTOOL:goof:source'`" = "1" ] )
	then
		${HOME}/installscripts/InstallGo.sh ${buildos}							
		DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -o DPkg::Lock::Timeout=-1  -qq -y install make	#####DEBIAN-GOOFYS-SOURCE#####
		/usr/bin/git clone https://github.com/kahing/goofys.git						#####DEBIAN-GOOFYS-SOURCE#####
		cd goofys											#####DEBIAN-GOOFYS-SOURCE#####
		make install											#####DEBIAN-GOOFYS-SOURCE#####
		goofys="`/usr/bin/find / -type f -name "goofys" -print`"					#####DEBIAN-GOOFYS-SOURCE#####
		/bin/mv ${goofys} /usr/bin									#####DEBIAN-GOOFYS-SOURCE-SKIP#####
		/bin/chmod 755 /usr/bin/goofys									#####DEBIAN-GOOFYS-SOURCE#####
		cd ..												#####DEBIAN-GOOFYS-SOURCE#####
		rm -r ./goofys											#####DEBIAN-GOOFYS-SOURCE#####
	fi
fi
