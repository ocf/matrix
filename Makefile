DOCKER_REVISION ?= matrix-testing-$(USER)

SYNAPSE_DOCKER_TAG = docker-push.ocf.berkeley.edu/synapse:$(DOCKER_REVISION)
BRIDGE_DOCKER_TAG = docker-push.ocf.berkeley.edu/matrix-appservice-irc:$(DOCKER_REVISION)
RIOT_DOCKER_TAG = docker-push.ocf.berkeley.edu/riot:$(DOCKER_REVISION)

SYNAPSE_VERSION := v1.81.0
RIOT_VERSION := v1.11.28
BRIDGE_VERSION := release-0.35.1

.PHONY: cook-image
cook-image:
	docker build --build-arg synapse_version=$(SYNAPSE_VERSION) --pull -f Dockerfile.matrix -t $(SYNAPSE_DOCKER_TAG) .
	docker build --build-arg bridge_version=$(BRIDGE_VERSION) --pull -f Dockerfile.bridge -t $(BRIDGE_DOCKER_TAG) .
	docker build --build-arg riot_version=$(RIOT_VERSION) --pull -f Dockerfile.riot -t $(RIOT_DOCKER_TAG) .

.PHONY: push-image
push-image:
	docker push $(SYNAPSE_DOCKER_TAG)
	docker push $(BRIDGE_DOCKER_TAG)
	docker push $(RIOT_DOCKER_TAG)

