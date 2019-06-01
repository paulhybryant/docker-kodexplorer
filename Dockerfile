ARG ARCH=docker.io
FROM ${ARCH}/php:apache

LABEL maintainer="paulhybryant@gmail.com"

COPY qemu-aarch64-static /usr/bin/

# Enable non-free and contrib repositories
RUN dist=$(sed -n -r 's/VERSION=[^(]*\((.*)\).*/\1/p' /etc/os-release) \
  && sed -i -e "s/\(.* $dist main\)/\1 contrib non-free/" -e "s/\(.* $dist\/updates main\)/\1 contrib non-free/" /etc/apt/sources.list \
  && cat /etc/apt/sources.list \
  && for i in $(seq 1 8); do mkdir -p "/usr/share/man/man${i}"; done

RUN apt-get update && apt-get install -y \
        apt-utils \
        default-jre \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libreoffice \
        ttf-mscorefonts-installer \
        vim \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install Chinese Fonts
RUN apt-get install -y xfonts-wqy ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-uming

ADD kodexplorer4.40.tar.gz /var/www/html/

# RUN if [ "${ARCH}" = "arm64v8" ]; then binarch="arm64"; else binarch="amd64"; fi && \
  # curl -L "https://github.com/tianon/gosu/releases/download/1.11/gosu-${binarch}" -o /usr/bin/gosu && \
  # chmod +x /usr/bin/gosu

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
VOLUME ["/var/www/html/data/User"]
