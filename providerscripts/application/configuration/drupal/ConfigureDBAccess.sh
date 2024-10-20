
if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:virgin`" = "1" ] )
then
	exit
fi

if ( [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh drupal_settings.php`" != "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/GetFromConfigDatastore.sh drupal_settings.php ${HOME}/runtime/drupal_settings.php
fi

if ( [ ! -f ${HOME}/runtime/CONFIG_PRIMED ] && [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh drupal_settings.php`" = "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/PutToConfigDatastore.sh /var/www/html/sites/default/settings.php
	if ( [ "$?" = "0" ] )
 	then
  		/bin/touch ${HOME}/runtime/CONFIG_PRIMED
	fi
fi

if ( [ ! -f ${HOME}/runtime/DRUPAL_CONFIG_SET ] && [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh drupal_settings.php`" != "" ] )
then	
	${HOME}/providerscripts/datastore/configwrapper/GetFromConfigDatastore.sh drupal_settings.php ${HOME}/runtime/drupal_settings.php
 	if ( [ -f /var/www/html/sites/default/settings.php ] )
  	then
   		/bin/rm /var/www/html/sites/default/settings.php
	fi
 	/bin/cp ${HOME}/runtime/drupal_settings.php /var/www/html/sites/default/settings.php
  	/bin/chown www:data-www:data /var/www/html/sites/default/settings.php
   	/bin/chmod 600 /var/www/html/sites/default/settings.php
  	/bin/touch ${HOME}/runtime/DRUPAL_CONFIG_SET
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

if ( [ ! -d  /var/www/private/default_images ] )
then
	/bin/mkdir -p /var/www/private/default_images
	/bin/cp -r /var/www/html/sites/default/files/private/* /var/www/private
	/bin/chown -R www-data:www-data /var/www/private
fi

#This is the php temporary upload directory
if ( [ ! -d /var/www/html/tmp ] )
then
	/bin/mkdir -p /var/www/html/tmp
 	/bin/chown www-data:www-data /var/www/html/tmp
	/bin/chmod 755 /var/www/html/tmp
fi

if ( [ ! -d /var/www/tmp ] )
then
	/bin/mkdir -p /var/www/tmp
	/bin/chmod 755 /var/www/tmp
	/bin/chown www-data:www-data /var/www/tmp
fi
