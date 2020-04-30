FROM php:7.4.2-apache-buster

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844

ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*


# Install useful tools and install important libaries
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nano wget \
      dialog \
      libsqlite3-dev \
      libsqlite3-0 && \
    apt-get -y --no-install-recommends install default-mysql-client \
      zlib1g-dev \
      libzip-dev \
      libicu-dev && \
    apt-get -y --no-install-recommends install --fix-missing apt-utils \
      build-essential \
      git \
      curl \
      libonig-dev && \
    apt-get -y --no-install-recommends install --fix-missing libcurl4 \
      libcurl4-openssl-dev \
      zip \
    openssl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install xdebug
RUN pecl install xdebug-2.8.0 && \
    docker-php-ext-enable xdebug

# Install redis
RUN pecl install redis-5.1.1 && \
    docker-php-ext-enable redis

# Other PHP7 Extensions

RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install pdo_sqlite && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install curl && \
    docker-php-ext-install tokenizer && \
    docker-php-ext-install json && \
    docker-php-ext-install zip && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install gettext

# Install Freetype
RUN apt-get -y update && \
    apt-get --no-install-recommends install -y libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd

# Moodle
#ADD root/ /
# Fix the original permissions of /tmp, the PHP default upload tmp dir.
#RUN chmod 777 /tmp && chmod +t /tmp

# Setup the required extensions.
#ARG DEBIAN_FRONTEND=noninteractive
#RUN /tmp/setup/php-extensions.sh
#RUN /tmp/setup/oci8-extension.sh
#ENV LD_LIBRARY_PATH /usr/local/instantclient

#RUN mkdir /var/www/moodledata && chown www-data /var/www/moodledata && \
#    mkdir /var/www/phpunitdata && chown www-data /var/www/phpunitdata && \
#    mkdir /var/www/behatdata && chown www-data /var/www/behatdata && \
#    mkdir /var/www/behatfaildumps && chown www-data /var/www/behatfaildumps
# End Moodle

# Enable apache modules
RUN a2enmod rewrite headers

# Cleanup
RUN rm -rf /usr/src/*
