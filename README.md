# Symfony Starter Kit

Makefile script to give you a simple Symfony environment out-of-the-box, similar to Laravel Sail.

### Includes

* Nginx
* Postgres
* PHP 8.2
* Node.js with Yarn
* Xdebug

### Using this kit

Clone it. Run `make create-skeleton` or `make create-webapp`.

Other utility commands are provided; to see all available features, just run `make` without any additional arguments.

### Structure

In order keep the underlying Docker infrastructure isolated from the Symfony environment, the application code will be
installed to an `app` directory which is generated when you run `make create-...`.

Commands such as `make php-shell` or `make node-shell` will mount directly at the Symfony project's root in the `app`
directory, so you don't need to worry about the extra directory level.

### Xdebug

Xdebug is included, and turned `off` by default. To enable it, set the `XDEBUG_MODE` environment variable
in `docker/docker-compose-xdebug.override.yml` to whatever mode(s) you want.

Lots of other settings can be modified through the `XDEBUG_CONFIG` environment variable, described on the official
[Xdebug manual page](https://xdebug.org/docs/all_settings).

Additionally, you can modify the `docker/php/conf.d/xdebug.ini` file to make any config changes which can't be expressed
via the `XDEBUG_CONFIG` variable.

After you've made any edits, you should then run `make restart` to load your config changes into the Docker PHP
container.

Example:

```yaml
services:
  php:
    environment:
      XDEBUG_MODE: develop,debug,coverage
      XDEBUG_CONFIG: xdebug.cli_color=2 log=/tmp/xdebug.log
```