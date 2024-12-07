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

	. ${HOME}/providerscripts/application/InstallApplication.sh

	if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:baseline`" = "1" ] )
	then
		. ${HOME}/providerscripts/application/branding/ApplyApplicationBranding.sh
		. ${HOME}/providerscripts/application/customise/CustomiseApplication.sh
	fi
	${HOME}/providerscripts/application/customise/AdjustApplicationInstallationByApplication.sh

	/bin/chown -R www-data:www-data /var/www/* > /dev/null 2>&1
	/usr/bin/find /var/www -type d -exec chmod 755 {} \;
	/usr/bin/find /var/www -type f -exec chmod 644 {} \;
	/bin/chmod 755 /var/www/html
	/bin/chown www-data:www-data /var/www/html
fi
