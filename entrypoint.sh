#!/bin/bash

for p in /plugins/*/; do
  ln -s ${p} /var/www/html/plugins/$(basename ${p})
done

apache2-foreground
