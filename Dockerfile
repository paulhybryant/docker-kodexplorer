ARG ARCH=docker.io
FROM ${ARCH}/php:apache

LABEL maintainer="paulhybryant@gmail.com"

COPY hooks/qemu-aarch64-static /usr/bin/

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
        unzip \
        vim \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install Chinese Fonts
RUN apt-get install -y xfonts-wqy ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-uming

ADD kodbox.1.09.zip /tmp
RUN unzip /tmp/kodbox.1.09.zip -d /var/www/html/
ADD doc2pdf_v1.1.zip /tmp
RUN unzip /tmp/doc2pdf_v1.1.zip -d /var/www/html/plugins/
RUN mv /var/www/html/plugins/kodexplorer-plugins-doc2pdf-1.1 /var/www/html/plugins/doc2pdf

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
VOLUME ["/var/www/html/data/User"]
