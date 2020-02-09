DOCKER_REVISION ?= matrix-testing-$(USER)
DOCKER_TAG = docker-push.ocf.berkeley.edu/synapse:$(DOCKER_REVISION)
RANDOM_PORT := $(shell expr $$(( 8000 + (`id -u` % 1000) + 2 )))

SYNAPSE_VERSION := v1.9.1-py3

.PHONY: cook-image
cook-image:
	docker build --build-arg synapse_version=$(SYNAPSE_VERSION) --pull -t $(DOCKER_TAG) .

.PHONY: push-image
push-image:
	docker push $(DOCKER_TAG)

