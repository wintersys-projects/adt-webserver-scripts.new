#!/bin/sh
###################################################################################
# Author: Peter Winter
# Date :  9/4/2016
# Description: Install the s3cmd tool for manipulating the Datastores
####################################################################################
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
#####################################################################################
#####################################################################################
#set -x

BUILDOS="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'BUILDOS'`"

apt=""
if ( [ "`${HOME}/providerscripts/utilities/ExtractBuildStyleValues.sh "PACKAGEMANAGER" | /usr/bin/awk -F':' '{print $NF}'`" = "apt" ] )
then
	apt="/usr/bin/apt-get"
elif ( [ "`${HOME}/providerscripts/utilities/ExtractBuildStyleValues.sh "PACKAGEMANAGER" | /usr/bin/awk -F':' '{print $NF}'`" = "apt-fast" ] )
then
	apt="/usr/sbin/apt-fast"
fi

if ( [ "${apt}" != "" ] )
then
	if ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTORETOOL:s3cmd'`" = "1" ] )
 	then
		if ( [ "${BUILDOS}" = "ubuntu" ] )
		then
			DEBIAN_FRONTEND=noninteractive ${apt} -o DPkg::Lock::Timeout=-1 -qq -y install s3cmd	#####UBUNTU-S3CMD-REPO#####
		fi

		if ( [ "${BUILDOS}" = "debian" ] )
		then
			DEBIAN_FRONTEND=noninteractive ${apt} -o DPkg::Lock::Timeout=-1 -qq -y install s3cmd	#####DEBIAN-S3CMD-REPO#####
		fi
	elif ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTORETOOL:s5cmd'`" = "1" ] )
 	then
  		if ( [ "${BUILDOS}" = "ubuntu" ] )
		then
  			/usr/bin/go install github.com/peak/s5cmd/v2@latest					#####UBUNTU-S5CMD-REPO#####
			/bin/cp ${HOME}/go/bin/s5cmd /usr/bin/s5cmd						#####UBUNTU-S5CMD-REPO#####
   		fi

     		if ( [ "${BUILDOS}" = "debian" ] )
		then
  			/usr/bin/go install github.com/peak/s5cmd/v2@latest					#####DEBIAN-S5CMD-REPO#####
			/bin/cp ${HOME}/go/bin/s5cmd /usr/bin/s5cmd						#####DEBIAN-S5CMD-REPO#####
   		fi
  	fi
fi

if ( [ -f ${HOME}/.s3cfg ] )
then
	bin/cp ${HOME}/.s3cfg /root
fi
