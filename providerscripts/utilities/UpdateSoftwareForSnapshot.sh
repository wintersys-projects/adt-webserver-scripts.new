if ( [ -f ${HOME}/runtime/WEBSERVER_UPDATED_FOR_SNAPSHOT ] && [ ! -f ${HOME}/runtime/SOFTWARE_UPDATED_FOR_SNAPSHOT ] )
then
    /bin/touch ${HOME}/runtime/SOFTWARE_UPDATED_FOR_SNAPSHOT
    ${HOME}/providerscripts/utilities/UpdateSoftware.sh
fi
