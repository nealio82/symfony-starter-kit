FROM php:8.2-fpm-alpine

# PHP environment / Symfony application dependencies
RUN apk --no-cache update && apk --no-cache add bash git
RUN apk add --no-cache zip libzip-dev postgresql-dev

RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_pgsql

# xdebug
RUN apk add --update linux-headers
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del -f .build-deps

# Composer
COPY --from=docker.io/composer:2.6.5 /usr/bin/composer /usr/bin/
