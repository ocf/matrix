DOCKER_REVISION ?= matrix-testing-$(USER)
SYNAPSE_DOCKER_TAG = docker-push.ocf.berkeley.edu/synapse:$(DOCKER_REVISION)
RIOT_DOCKER_TAG = docker-push.ocf.berkeley.edu/riot:$(DOCKER_REVISION)
RANDOM_PORT := $(shell expr $$(( 8000 + (`id -u` % 1000) + 2 )))

SYNAPSE_VERSION := v1.9.1-py3
RIOT_VERSION := v1.5.15

.PHONY: cook-image
cook-image:
	docker build --build-arg synapse_version=$(SYNAPSE_VERSION) --pull -t $(SYNAPSE_DOCKER_TAG) .
	docker build -f Dockerfile.riot --build-arg riot_version=$(RIOT_VERSION) --pull -t $(RIOT_DOCKER_TAG) .

.PHONY: push-image
push-image:
	docker push $(SYNAPSE_DOCKER_TAG)
	docker push $(RIOT_DOCKER_TAG)

