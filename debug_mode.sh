#!/bin/sh -x

#check if root or sudo.
if ! [ $(id -u) = 0 ]; then
   echo "This script must run as root or sudo!"
   exit 1
fi

cd /var/www/mangapie

if grep -Fxq "APP_DEBUG=false" /var/www/mangapie/.env; then
   echo "> DEBUG"
   composer install
   sed -i s/APP_DEBUG=false/APP_DEBUG=true/g .env
   php artisan config:cache
fi

if grep -Fxq "APP_DEBUG=true" /var/www/mangapie/.env; then
   echo "> No DEBUG"
   composer install --no-dev
   sed -i s/APP_DEBUG=true/APP_DEBUG=false/g .env
   php artisan config:cache
fi
