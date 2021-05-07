#!/bin/bash -x

cd /var/www/

. ./.env

chmod -R 0777 ./storage
chmod -R 0777 ./bootstrap
chmod -R 0777 ./resources

echo "Re-generate classmap via composer dump-autoload....."


# Install required packages using composer command
/usr/local/bin/php -d memory_limit=-1 /usr/local/bin/composer install
/usr/local/bin/php -d memory_limit=-1 /usr/local/bin/composer dump-autoload

echo "clear laravel cache....."
/usr/local/bin/php artisan cache:clear

echo "Laravel migration START....."
/usr/local/bin/php artisan migrate --force
echo "Laravel migration END....."

echo "Laravel seeder START....."
/usr/local/bin/php artisan db:seed --force
echo "Laravel seeder END....."


rm -rf /tmp/*

echo "BUILD VERSION: ${APP_BUILD_VERSION}"

apache2-foreground
