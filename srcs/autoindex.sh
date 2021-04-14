#!/bin/bash

if [[ "$(grep -o "autoindex on;" ./nginx.conf)" = "autoindex on;" ]]; then
cp var/www/html/nginx_off.conf /etc/nginx/sites-available/ && rm -f /etc/nginx/sites-available/nginx_on.conf
elif [[ "$(grep -o "autoindex off;" ./nginx.conf)" = "autoindex off;" ]]; then
cp var/www/html/nginx_on.conf /etc/nginx/sites-available/ && rm -f /etc/nginx/sites-available/nginx_off.conf
fi