# Base image
FROM ubuntu:20.04

# Set working directory
WORKDIR /var/www/html

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV PHP_MEMORY_LIMIT=-1
ENV COMPOSER_MEMORY_LIMIT=-1

# Install dependencies
RUN apt-get update -yqq && apt-get install -y \
    build-essential ca-certificates curl cron g++ gifsicle git gnupg graphviz \
    htop jpegoptim libcurl4-openssl-dev libfreetype6-dev libicu-dev \
    libmcrypt-dev libonig-dev libpng-dev libpq-dev libssl-dev libxml2-dev \
    libzip-dev optipng pngquant supervisor unzip vim \
    zip zlib1g-dev

# Install PHP
RUN mkdir -p ~/.gnupg \
    && chmod 600 ~/.gnupg \
    && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
    && apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
    && echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y php8.1-bcmath php8.1-cli php8.1-curl php8.1-dev \
    php8.1-fpm php8.1-gd php8.1-grpc php8.1-igbinary php8.1-imap php8.1-intl \
    php8.1-ldap php8.1-mbstring php8.1-memcached php8.1-msgpack php8.1-mysql \
    php8.1-pcov php8.1-pgsql php8.1-readline php8.1-redis php8.1-soap \
    php8.1-sqlite3 php8.1-swoole php8.1-xdebug php8.1-xml php8.1-zip php8.1-zstd

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Install caddy
COPY --from=caddy:2 /usr/bin/caddy /usr/local/bin/caddy
