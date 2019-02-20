FROM php:apache

RUN apt-get update && apt-get install -y \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN git clone --progress https://github.com/paulhybryant/kodexplorer.git /var/www/html/

RUN chown -R www-data:www-data /var/www/html

VOLUME ["/var/www/html/plugins"]
