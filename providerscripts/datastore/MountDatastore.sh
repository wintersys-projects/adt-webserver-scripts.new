#!/bin/sh
#########################################################################################
# Author: Peter Winter
# Date :  9/4/2016
# Description: Put files into a bucket in the datastore
##########################################################################################
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
#########################################################################################
#########################################################################################
#set -x

datastore_to_mount="$1"

if ( [ "`${HOME}/providerscripts/utilities/CheckBuildStyle.sh 'DATASTORETOOL:s3cmd'`" = "1" ] )
then
	if ( [ "`/usr/bin/s3cmd ls s3://${datastore_to_mount} 2>/dev/null`" != "" ] )
	then
		exit
	fi
	/usr/bin/s3cmd mb s3://${datastore_to_mount}
	if ( [ "$?" = "0" ] )
	then
		exit
	fi
fi


