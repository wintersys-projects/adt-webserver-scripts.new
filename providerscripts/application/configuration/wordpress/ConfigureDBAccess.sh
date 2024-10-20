if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:virgin`" = "1" ] )
then
	exit
fi

if ( [ ! -f ${HOME}/runtime/CONFIG_PRIMED ] && [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh configuration.php.default`" = "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/PutToConfigDatastore.sh /var/www/html/configuration.php.default
	if ( [ "$?" = "0" ] )
 	then
  		/bin/touch ${HOME}/runtime/CONFIG_PRIMED
	fi
fi
