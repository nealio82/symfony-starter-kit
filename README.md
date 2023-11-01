# Symfony Starter Kit

Makefile script to give you a simple Symfony environment out-of-the-box, similar to Laravel Sail.

### Includes

* Nginx
* Postgres
* PHP 8.2
* Xdebug (coming soon)

### Using this kit

Clone it. Run `make create-skeleton` or `make create-webapp`.

In order keep the underlying Docker infrastructure isolated from the Symfony environment, the application code will be
installed to an `app` directory which is generated when you run `make create-...`.

Other utility commands are provided; to see all available features, just run `make` without any additional arguments.