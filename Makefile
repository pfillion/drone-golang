SHELL = /bin/sh
.SUFFIXES:
.PHONY: help
.DEFAULT_GOAL := help

# Docker parameters
NS ?= pfillion
VERSION ?= latest
IMAGE_NAME ?= drone-golang
CONTAINER_NAME ?= drone-golang
CONTAINER_INSTANCE ?= default
VCS_REF=$(shell git rev-parse --short HEAD)
BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%S")

help: ## Show the Makefile help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build the image form Dockerfile
	docker build \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VCS_REF=$(VCS_REF) \
		--build-arg VERSION=$(VERSION) \
		-t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

push: ## Push the image to a registry
ifdef DOCKER_USERNAME
	echo "$(DOCKER_PASSWORD)" | docker login -u "$(DOCKER_USERNAME)" --password-stdin
endif
	docker push $(NS)/$(IMAGE_NAME):$(VERSION)
    
shell: ## Run shell command in the container
	docker run --rm --name $(CONTAINER_NAME)-$(CONTAINER_INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(IMAGE_NAME):$(VERSION) /bin/sh

test: ## Run all tests
	bats tests
	
release: build push ## Build and push the image to a registry