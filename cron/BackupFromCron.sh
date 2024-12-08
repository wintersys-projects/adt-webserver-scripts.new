#!/bin/sh
############################################################################################################################
# Description: This script will perform a backup of the webroot when it is called from cron
# When you have multiple webservers running (possibly 10 or more) you want to have an authoritative webserver
# which is performing the backup. I do this by inserting a random sleep period between 1 and 300 seconds which
# enables us to obtain an 'as good as atomic' lock from the datastore which other webservers can query to see
# if another webserver has claimed to be authoritative before them so that the webserver which is query can
# stand down from this backup attempt. This means that we only get one webserver as the "backup" webserver
# or the webserver performing the backup for this backup cycle (hourly, daily, weekly) and so on. 
# In fringe conditions its possible that a webserver might be shutdown or terminated as part of a scaling action
# mid way through the backup process which can take quite a few 10s of seconds to complete. This is why its very
# much recommended to always have "supersafe" backups enabled in your template because "supersafe backups"
# makes two backups in sequence (one to git and one to the datastore) meaning that if the backup process that is i
# chronologically first fails or is interrupted the "other" backup is still intergral and any subsequent scaling processes 
# will be able to use the backup version is valid and or exists
# The backups run in sequence from cron at set periodicities (you are of course at liberty to set a different sequence
# for your backup taking process by modifying the cron script). 
# You can also take manual backups from the command line on the buildmachine and you will find scripts in
# the direcory ${BUILD_HOME}/helperscripts relating to making backups and baselines of your application webroot.
# Look there for further explaination
# Date: 16/11/2016
# Author: Peter Winter
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
#set -x

periodicity="${1}"

/bin/sleep "`/usr/bin/shuf -i1-60 -n1`"

${HOME}/providerscripts/backupscripts/Backup.sh "${periodicity}"

