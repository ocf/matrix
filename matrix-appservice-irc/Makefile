DOCKER_REVISION ?= matrix-appservice-irc-testing-$(USER)
DOCKER_TAG = docker-push.ocf.berkeley.edu/matrix-appservice-irc:$(DOCKER_REVISION)
RANDOM_PORT := $(shell expr $$(( 8000 + (`id -u` % 1000) + 2 )))

BRIDGE_VERSION := release-0.17.0-rc3

.PHONY: cook-image
cook-image:
	docker build --build-arg bridge_version=$(BRIDGE_VERSION) --pull -t $(DOCKER_TAG) .

.PHONY: push-image
push-image:
	docker push $(DOCKER_TAG)

