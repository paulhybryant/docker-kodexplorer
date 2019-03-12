#!/bin/bash

# for p in /plugins/*/; do
  # ln -s ${p} /var/www/html/plugins/$(basename ${p})
# done

chmod -R 777 /var/www/html/
cd /var/www/html
apache2-foreground
