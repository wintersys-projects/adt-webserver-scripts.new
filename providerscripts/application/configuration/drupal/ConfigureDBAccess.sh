
if ( [ "`${HOME}/providerscripts/utilities/CheckConfigValue.sh BUILDARCHIVECHOICE:virgin`" = "1" ] )
then
	exit
fi

if ( [ ! -d  /var/www/private/default_images ] )
then
	/bin/mkdir -p /var/www/private/default_images
fi

#This is the php temporary upload directory
if ( [ ! -d /var/www/html/tmp ] )
then
	/bin/mkdir -p /var/www/html/tmp
 	/bin/chown www-data:www-data /var/www/html/tmp
  /bin/chmod 755 /var/www/html/tmp
fi

if ( [ "`${HOME}/providerscripts/datastore/configwrapper/ListFromConfigDatastore.sh drupal_settings.php`" != "" ] )
then
	${HOME}/providerscripts/datastore/configwrapper/GetFromConfigDatastore.sh drupal_settings.php ${HOME}/runtime/drupal_settings.php.$$
fi

