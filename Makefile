.DEFAULT_GOAL := help

SHELL := /bin/bash
COMPOSE := docker compose -f docker/docker-compose.yml -f docker/docker-compose-xdebug.override.yml
APP := $(COMPOSE) exec -T php

##@ Setup / common commands

.PHONY: create-skeleton
create-skeleton: up install-symfony-skeleton ## Brings up infrastructure and creates a skeleton application

.PHONY: create-webapp
create-webapp: create-skeleton install-symfony-webapp yarn-install ## Brings up infrastructure and creates a new full-stack application

.PHONY: dev
dev: up composer yarn-install ## Resume development on an existing application and install frontend dependencies

.PHONY: up
up: ## Bring everything up in development mode
	$(COMPOSE) up -d --build --force-recreate

.PHONY: down
down: ## Stop and clean-up the application (remove containers, networks, images, and volumes)
	$(COMPOSE) down -v --remove-orphans

.PHONY: restart
restart: down up ## Restart the application in development mode

##@ Utility commands

.PHONY: install-symfony-skeleton
install-symfony-skeleton: ## Installs the basic skeleton once the environment is up
	$(APP) composer create-project symfony/skeleton . --no-interaction --no-ansi

.PHONY: install-symfony-webapp
install-symfony-webapp: ## Installs the webapp pack into the skeleton environment
	$(APP) composer require webapp

.PHONY: composer
composer: ## Installs the latest Composer dependencies within running instance
	$(APP) composer install --no-interaction --no-ansi

##@ Frontend

.PHONY: yarn-build
yarn-build: ## Build frontend assets
	$(COMPOSE) run node yarn build

.PHONY: yarn-install
yarn-install: ## Install deps with yarn
	$(COMPOSE) run node yarn install

.PHONY: yarn-watch ## Keep frontend build process alive and rebuild if source files are changed
yarn-watch: ## Keep frontend build process alive and rebuild if source files are changed
	$(COMPOSE) run node yarn watch


##@ Running Instance

.PHONY: php-shell
php-shell: ## Provides shell access to the running PHP container instance
	$(COMPOSE) exec php bash

.PHONY: node-shell
node-shell: ## Provides shell access to a Node container instance
	$(COMPOSE) run node bash

.PHONY: logs
logs: ## Tails all container logs
	$(COMPOSE) logs -f

.PHONY: ps
ps: ## List all running containers
	$(COMPOSE) ps

.PHONY: open-web
open-web: ## Opens the website in the default browser
	open "http://0.0.0.0:8080"

# https://www.thapaliya.com/en/writings/well-documented-makefiles/
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
