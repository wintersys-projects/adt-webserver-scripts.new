#!/bin/sh
###########################################################################################################
# Description: This script will  install an application sourcecode. First of all it looks in the git repo
# and then in the datastore.
# Author: Peter Winter
# Date: 05/02/2017
###########################################################################################################
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
set -x
WEBSITE_URL="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'WEBSITEURL'`"
WEBSITE_NAME="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'WEBSITENAME'`"
WEBSITE_SUBDOMAIN="`/bin/echo ${WEBSITE_URL} | /usr/bin/awk -F'.' '{print $1}'`"
DATASTORE_CHOICE="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'DATASTORECHOICE'`"
BUILD_IDENTIFIER="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'BUILD_IDENTIFIER'`"
BUILD_ARCHIVE_CHOICE="`${HOME}/providerscripts/utilities/ExtractConfigValue.sh 'BUILDARCHIVECHOICE'`"

if ( [ -d /var/www/html ] )
then
        /bin/rm -r /var/www/html/* 
        /bin/rm -r /var/www/html/.*
else
        /bin/mkdir -p /var/www/html
fi

cd /var/www/html

cd ${HOME}


application_datastore="`/bin/echo ${WEBSITE_URL} | /bin/sed 's/\./-/g'`-${BUILD_ARCHIVE_CHOICE}/applicationsourcecode.tar.gz"
${HOME}/providerscripts/datastore/GetFromDatastore.sh "${DATASTORE_CHOICE}" ${application_datastore}
/bin/tar xvfz ${HOME}/applicationsourcecode.tar.gz
/bin/rm ${HOME}/applicationsourcecode.tar.gz
/bin/mv ${HOME}/tmp/backup/* /var/www/html
/bin/rm -rf ${HOME}/tmp
