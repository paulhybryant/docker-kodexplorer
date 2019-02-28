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
  && curl -L -O https://github.com/paulhybryant/kodexplorer/archive/v4.37.tar.gz \
  && tar -xzvf /tmp/v4.37.tar.gz -C /var/www/html/ --strip-components=1 \
  && chown -R www-data:www-data /var/www/html

VOLUME ["/plugins"]

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
