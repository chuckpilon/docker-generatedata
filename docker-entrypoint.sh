#!/bin/bash

echo "-> checking environment variables"
test ${GD_DB_HOSTNAME}
test ${GD_DB_NAME}
test ${GD_DB_USERNAME}
test ${GD_DB_PASSWORD}
export GD_DB_TABLE_PREFIX=${GD_DB_TABLE_PREFIX:-"gd_"}
export GD_ENCRYPTION_SALT=${GD_ENCRYPTION_SALT:-"changeme"}
export GD_API_ENABLED=${GD_API_ENABLED:-"true"}
export GD_MAX_GENERATED_ROWS=${GD_MAX_GENERATED_ROWS:-"10000000"}
export GD_DEFAULT_NUM_ROWS=${GD_DEFAULT_NUM_ROWS:-"10"}

echo "-> configuring application"
/usr/local/bin/confd -onetime -backend env

echo "-> starting php-fpm and nginx"
/usr/bin/supervisord -n -c /etc/supervisord.conf
