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
	${HOME}/installscripts/InstallJQ.sh ${buildos}
        version="`/usr/bin/curl -L https://api.github.com/repos/go-acme/lego/releases/latest | /usr/bin/jq -r '.name'`" #####UBUNTU-LEGO-REPO#####
        if ( [ -f /usr/bin/lego ] )                                                                                     #####UBUNTU-LEGO-REPO#####
        then                                                                                                            #####UBUNTU-LEGO-REPO#####
                /bin/rm /usr/bin/lego                                                                                   #####UBUNTU-LEGO-REPO#####
        fi                                                                                                              #####UBUNTU-LEGO-REPO#####
        /usr/bin/wget -c https://github.com/xenolf/lego/releases/download/${version}/lego_${version}_linux_amd64.tar.gz -O- | /usr/bin/tar -xz -C /usr/bin      #####UBUNTU-LEGO-REPO-SKIP##### 
fi

if ( [ "${buildos}" = "debian" ] )
then
	${HOME}/installscripts/InstallJQ.sh ${buildos}
        version="`/usr/bin/curl -L https://api.github.com/repos/go-acme/lego/releases/latest | /usr/bin/jq -r '.name'`" #####DEBIAN-LEGO-REPO#####
        if ( [ -f /usr/bin/lego ] )                                                                                     #####DEBIAN-LEGO-REPO#####
        then                                                                                                            #####DEBIAN-LEGO-REPO#####
                /bin/rm /usr/bin/lego                                                                                   #####DEBIAN-LEGO-REPO#####
        fi                                                                                                              #####DEBIAN-LEGO-REPO#####
        /usr/bin/wget -c https://github.com/xenolf/lego/releases/download/${version}/lego_${version}_linux_amd64.tar.gz -O- | /usr/bin/tar -xz -C /usr/bin      #####DEBIAN-LEGO-REPO-SKIP##### 
fi
