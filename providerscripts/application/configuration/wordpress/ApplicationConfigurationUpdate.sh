#!/bin/sh
######################################################################################
# Author: Peter Winter
# Date :  07/07/2016
# Description: This will update the application configuration for wordpress
#####################################################################################
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
#######################################################################################
#######################################################################################
#set -x

/usr/bin/php -ln ${HOME}/runtime/wordpress_config.php
if ( [ "$?" != "0" ] )
then
	/bin/echo "Syntax error detected in your configuration file"
	exit
fi
/usr/bin/run ${HOME}/providerscripts/datastore/configwrapper/PutToConfigDatastore.sh ${HOME}/runtime/wordpress_config.php wordpress_config.php
