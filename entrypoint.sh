#!/bin/bash

# for p in /plugins/*/; do
  # ln -s ${p} /var/www/html/plugins/$(basename ${p})
# done

USER_ID=$(stat -c %u /var/www/html/app)
GROUP_ID=$(stat -c %g /var/www/html/app)
groupmod -g $GROUP_ID www-data
usermod -u $USER_ID -g www-data www-data
chown www-data:www-data -R /var/www/html
chmod 777 -R /var/www/html

export HOME=/var/www/html
cd ${HOME}
apache2-foreground
# exec /usr/bin/gosu www-data apache2-foreground
