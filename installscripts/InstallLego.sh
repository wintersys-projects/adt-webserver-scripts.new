#!/bin/sh
######################################################################################################
# Description: This script will install lego
# Author: Peter Winter
# Date: 17/01/2017
#######################################################################################################
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
#######################################################################################################
#######################################################################################################
#set -x

if ( [ "${1}" != "" ] )
then
	buildos="${1}"
fi

if ( [ "${buildos}" = "ubuntu" ] )
then
	cwd="`/usr/bin/pwd`"					#####UBUNTU-LEGO-SOURCE#####
	/bin/mkdir -p /usr/local/src/lego			#####UBUNTU-LEGO-SOURCE#####
	cd /usr/local/src/lego					#####UBUNTU-LEGO-SOURCE#####
	version="`/usr/bin/wget -O- -q https://github.com/go-acme/lego/releases/latest | /bin/grep -oP 'Release\K.*' | /usr/bin/head -1 | /usr/bin/awk '{print $1}' | /bin/sed "s/[^[:digit:].-]//g"`"	#####UBUNTU-LEGO-SOURCE##### 
	/usr/bin/wget https://github.com/xenolf/lego/releases/download/v${version}/lego_v${version}_linux_amd64.tar.gz    #####UBUNTU-LEGO-SOURCE#####
	/bin/tar xvfz lego*tar.gz				#####UBUNTU-LEGO-SOURCE#####
	/bin/rm *lego*tar.gz					#####UBUNTU-LEGO-SOURCE#####
	/bin/cp lego /usr/bin/					#####UBUNTU-LEGO-SOURCE#####
	cd ${cwd}						#####UBUNTU-LEGO-SOURCE-SKIP#####
fi

if ( [ "${buildos}" = "debian" ] )
then
	cwd="`/usr/bin/pwd`"					#####DEBIAN-LEGO-SOURCE#####
	/bin/mkdir -p /usr/local/src/lego			#####DEBIAN-LEGO-SOURCE#####
	cd /usr/local/src/lego					#####DEBIAN-LEGO-SOURCE#####
	version="`/usr/bin/wget -O- -q https://github.com/go-acme/lego/releases/latest | /bin/grep -oP 'Release\K.*' | /usr/bin/head -1 | /usr/bin/awk '{print $1}' | /bin/sed "s/[^[:digit:].-]//g"`" 	#####DEBIAN-LEGO-SOURCE#####
	/usr/bin/wget https://github.com/xenolf/lego/releases/download/v${version}/lego_v${version}_linux_amd64.tar.gz    #####DEBIAN-LEGO-SOURCE#####
	/bin/tar xvfz lego*tar.gz				#####DEBIAN-LEGO-SOURCE#####
	/bin/rm *lego*tar.gz					#####DEBIAN-LEGO-SOURCE#####
	/bin/cp lego /usr/bin/					#####DEBIAN-LEGO-SOURCE#####
	cd ${cwd}						#####DEBIAN-LEGO-SOURCE-SKIP#####
fi
