#!/bin/bash -x

cd /var/www/

/usr/local/bin/php -r "file_exists('.env') || copy('.env.server', '.env');"
. ./.env

while ! mysqladmin ping -h ${DB_HOST} --silent; do
    echo "Waiting for ${DB_HOST} to come online ...."
    sleep 5
done

echo "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};" | mysql -u ${DB_USERNAME} -p"${DB_PASSWORD}" -h ${DB_HOST}

if [ $(mysql -N -s -u $DB_USERNAME -p"${DB_PASSWORD}" -h $DB_HOST -e "select count(*) from information_schema.tables where table_schema='${DB_DATABASE}' and table_name='settings';") -eq 1 ]; then
    echo "Database alreday exists! ...";
else
    echo "Database is missing! ...."
    echo "Importing storage/database/initial_db.sql"
    mysql -u $DB_USERNAME -p"${DB_PASSWORD}" -h $DB_HOST $DB_DATABASE < storage/database/initial_db.sql
    echo "Database import completed."
fi

chmod -R 0777 ./storage
chmod -R 0777 ./bootstrap
chmod -R 0777 ./resources

echo "Re-generate classmap via composer dump-autoload....."

# Add GitHub Authentication using Token
/usr/local/bin/php /usr/local/bin/composer config -g github-oauth.github.com e42e745c4691ce89c3715ac7cc64b58f7fe7b34f

# Install required packages using composer command
/usr/local/bin/php -d memory_limit=-1 /usr/local/bin/composer install
/usr/local/bin/php -d memory_limit=-1 /usr/local/bin/composer dump-autoload

echo "clear laravel cache....."
/usr/local/bin/php artisan optimize:clear

echo "Laravel migration START....."
/usr/local/bin/php artisan migrate --force
echo "Laravel migration END....."

echo "Laravel seeder START....."
/usr/local/bin/php artisan db:seed --force
echo "Laravel seeder END....."


rm -rf /tmp/*

if [ -z "$1" ]
  then
    echo "No Scheduled Latest Task....."
  else
    echo "Scheduled Task START....."
    $1
    echo "Scheduled Task END....."
    echo "Stopping Task START....."
    sh /var/www/build/docker/stop_ecs_task.sh
    echo "Stopping Task END....."
fi

echo "BUILD VERSION: ${APP_BUILD_VERSION}"

apache2-foreground
