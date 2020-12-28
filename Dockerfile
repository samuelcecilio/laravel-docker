FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV PHP_MEMORY_LIMIT=-1
ENV COMPOSER_MEMORY_LIMIT=-1

# Install dependencies
RUN apt-get update -yqq && apt-get install -y \
    build-essential \
    curl \
    cron \
    gifsicle \
    git \
    g++ \
    graphviz \
    htop \
    jpegoptim \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libonig-dev \
    libpng-dev \
    libpq-dev \
    libssl-dev \
    libxml2-dev \
    libzip-dev \
    optipng \
    pngquant \
    supervisor \
    unzip \
    vim \
    zip \
    zlib1g-dev

# Install PECL and PEAR extensions
RUN pecl install redis
RUN docker-php-ext-enable redis

# Configure php extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install extensions
RUN docker-php-ext-install \
    bcmath \
    calendar \
    curl \
    exif \
    gd \
    iconv \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pcntl \
    tokenizer \
    xml \
    zip

# Install caddy
COPY --from=caddy:2 /usr/bin/caddy /usr/local/bin/caddy

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
