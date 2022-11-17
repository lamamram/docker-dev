#!/bin/bash

envsubst '${PHP_PORT}' < /home/app_php.conf > /etc/nginx/conf.d/app_php.conf
