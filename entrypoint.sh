#!/bin/bash

# for p in /plugins/*/; do
  # ln -s ${p} /var/www/html/plugins/$(basename ${p})
# done

cd /var/www/html
apache2-foreground

# groupadd -g "$GROUP_ID" kod
# useradd --shell /bin/bash -u "$USER_ID" -g kod -o -c "" -m kod
# export HOME=/home/kod

# exec /usr/bin/gosu kod "$@"
