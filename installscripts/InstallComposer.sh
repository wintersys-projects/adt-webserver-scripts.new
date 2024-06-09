
/usr/sbin/service crond stop
/usr/bin/apt update
/usr/bin/apt install php-cli unzip
cd ~
/usr/bin/curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`/usr/bin/curl -sS https://composer.github.io/installer.sig`
/usr/bin/php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
/usr/bin/php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
/usr/sbin/service crond start
