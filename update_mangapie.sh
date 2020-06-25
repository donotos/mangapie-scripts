#!/bin/sh -x

#check if root or sudo.
if ! [ $(id -u) = 0 ]; then
   echo "This script must run as root or sudo!"
   exit 1
fi

cd /var/www/mangapie

php artisan down
git pull
php artisan up

composer install --no-dev
composer dump
php artisan mangapie:init

