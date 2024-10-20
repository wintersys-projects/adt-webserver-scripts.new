if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:virgin`" = "1" ] )
then
	exit
fi

if ( [ ! -f ${HOME}/runtime/CONFIG_PRIMED ] && [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh wp-config-sample.php`" = "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/PutToConfigDatastore.sh /var/www/html/wp-config-sample.php
	if ( [ "$?" = "0" ] )
 	then
  		/bin/touch ${HOME}/runtime/CONFIG_PRIMED
	fi
fi

if ( [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh wp-config-sample.php`" != "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/GetFromConfigDatastore.sh wp-config-sample.php ${HOME}/runtime/wordpress_config.php

	if ( [ -f /var/www/html/wp-config.php ] )
 	then
		if ( [ "`/usr/bin/diff ${HOME}/runtime/wordpress_config.php /var/www/html/wp-config.php`" != "" ] )
		then
			/bin/mv ${HOME}/runtime/wordpress_config.php.$$ /var/www/html/wp-config.php
			/bin/chown www-data:www-data /var/www/html/wp-config.php
			/bin/chmod 600 /var/www/html/wp-config.php
		else
			/bin/rm ${HOME}/runtime/wordpress_config.php.$$
		fi
  	else
   		/bin/mv ${HOME}/runtime/wordpress_config.php /var/www/html/wp-config.php
	fi
   
fi

if ( [ ! -f ${HOME}/runtime/DB_PREFIX_SET ] )
then
	dbprefix="`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh DBPREFIX:*  | /usr/bin/awk -F':' '{print $NF}'`"

	if ( [ "${dbprefix}" = "" ] )
	then
		dbprefix="`/bin/cat /var/www/html/dbp.dat`"
	fi
 
	${HOME}/providerscripts/datastore/configwrapper/PutToConfigDatastore.sh DBPREFIX:${dbprefix}
 	/bin/touch ${HOME}/runtime/DB_PREFIX_SET
fi
