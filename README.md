# Symfony Starter Kit

Makefile script to give you a simple Symfony environment out-of-the-box, similar to Laravel Sail.

### Includes

* Nginx
* Postgres
* PHP 8.2
* Node.js with Yarn
* Xdebug (coming soon)

### Using this kit

Clone it. Run `make create-skeleton` or `make create-webapp`.

Other utility commands are provided; to see all available features, just run `make` without any additional arguments.

### Structure

In order keep the underlying Docker infrastructure isolated from the Symfony environment, the application code will be
installed to an `app` directory which is generated when you run `make create-...`.

Commands such as `make php-shell` or `make node-shell` will mount directly at the Symfony project's root in the `app`
directory, so you don't need to worry about the extra directory level.