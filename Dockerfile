FROM php:apache

RUN apt-get update && apt-get install -y \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        vim \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN cd /tmp/ \
  && curl -L https://github.com/kalcaddle/KodExplorer/archive/4.39.tar.gz | tar -xz -C /var/www/html/ --strip-components=1 \
  && chown -R www-data:www-data /var/www/html \
  && curl -L https://github.com/paulhybryant/kodexplorer-plugins/archive/v1.0.tar.gz | tar -xz -C /var/www/html/plugins --strip-components=1

VOLUME ["/plugins" "/var/www/html/data/User"]

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
