#!/bin/bash
composer dump-autoload --optimize
php artisan optimize
php artisan migrate --no-interaction --force
php artisan storage:link
supervisord -c supervisord.conf
