FROM php:8.2-fpm-alpine

# Apk install
RUN apk --no-cache update && apk --no-cache add bash git
RUN apk add --no-cache zip libzip-dev postgresql-dev

RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_pgsql

# Composer
COPY --from=docker.io/composer:2.6.5 /usr/bin/composer /usr/bin/
