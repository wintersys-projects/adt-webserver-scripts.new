if ( [ -f ${HOME}/runtime/WEBSERVER_READY ] )
then
  /bin/rm ${HOME}/runtime/CONFIG_PRIMED

  if ( [ ! -d /var/www/html ] )
then
	/bin/mkdir -p /var/www/html > /dev/null 2>&1
fi
cd /var/www/html
/bin/rm -r /var/www/html/* > /dev/null 2>&1
/bin/rm -r /var/www/html/.git > /dev/null 2>&1
/usr/bin/git init

/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
>&2 /bin/echo "${0} Installing the custom application"
/bin/echo "${0} Installing the custom application" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log

. ${HOME}/providerscripts/application/InstallApplication.sh

/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
>&2 /bin/echo "${0} Applying application specific customisations"
/bin/echo "${0} Applying application specific customisations" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:baseline`" = "1" ] )
then
	. ${HOME}/providerscripts/application/branding/ApplyApplicationBranding.sh
	. ${HOME}/providerscripts/application/customise/CustomiseApplication.sh
fi
${HOME}/providerscripts/application/customise/AdjustApplicationInstallationByApplication.sh

/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
>&2 /bin/echo "${0} Adjusting webroot permissions and ownerships"
/bin/echo "${0} Adjusting webroot permissions and ownerships" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
/bin/echo "${0} #######################################################################################" >> ${HOME}/logs/initialbuild/BUILD_PROCESS_MONITORING.log
/bin/chown -R www-data:www-data /var/www/* > /dev/null 2>&1
/usr/bin/find /var/www -type d -exec chmod 755 {} \;
/usr/bin/find /var/www -type f -exec chmod 644 {} \;
/bin/chmod 755 /var/www/html
/bin/chown www-data:www-data /var/www/html
