FROM 057096386119.dkr.ecr.us-east-1.amazonaws.com/php-7.3.13-apache-stretch:latest

RUN rm -rf /var/www/html && rm -rf /etc/apache2/sites-available/000-default.conf
COPY ./ /var/www/
COPY ./build/docker/000-default.conf /etc/apache2/sites-available/

# Install additional extensions
RUN apt-get update && apt-get install -y libpq-dev libicu-dev wget unzip libfreetype6-dev libjpeg62-turbo-dev libpng-dev mariadb-client libzip-dev git && \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr && \
    docker-php-ext-configure intl && \
    docker-php-ext-install pdo pdo_mysql mysqli bcmath gd zip intl

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

RUN a2enmod rewrite env

WORKDIR /var/www

RUN chmod -Rf +777 /var/www/bootstrap && chmod -Rf +777 /var/www/storage && chmod -Rf +777 /var/www/public
RUN rm -rf /var/www/public/storage
RUN mkdir -p /var/www/bootstrap/cache && chmod -Rf +777 /var/www/bootstrap && chmod -Rf +777 /var/www/storage
RUN mkdir -p /var/www/storage/framework/cache/data/ && chmod -Rf +777 /var/www/storage/framework/cache/data/
RUN mkdir -p /var/www/storage/app/public/app/logo/ && chmod -Rf +777 /var/www/storage/app/public/app/logo/

RUN cd /var/www

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --version=1.10.16 --filename=composer

# Add GitHub Authentication using Token
RUN php /usr/local/bin/composer config -g github-oauth.github.com e42e745c4691ce89c3715ac7cc64b58f7fe7b34f

# Install required packages using composer command
RUN php -d memory_limit=-1 /usr/local/bin/composer install \
    && php -d memory_limit=-1 /usr/local/bin/composer dump-autoload

RUN ln -s /var/www/storage/app/public /var/www/public/storage

EXPOSE 80

ENTRYPOINT ["/bin/sh","/var/www/build/docker/start.sh"]

CMD [""]
