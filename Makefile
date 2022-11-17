X86_IMAGES := yt-archive-x86 openvpn-client-x86 nextcloud-x86 jmusicbot-x86 technitium-dns-server-x86 minecraft-general-x86 fabric-auto-x86
ARM_IMAGES := yt-archive-arm openvpn-client-arm jmusicbot-arm technitium-dns-server-arm minecraft-general-arm fabric-auto-arm

## Echo options
.PHONY: help
help:
	@echo ""
	@echo "Options:"
	@echo "make build-x86	       # Build x86_64 images"
	@echo "make build-arm	       # Build arm64 images"
	@echo "make build-all 	       # Builds all images"
	@echo "make push-x86	       # Push x86_64 images"
	@echo "make push-arm	       # Push arm64 images"
	@echo "make push-all  	       # Pushes all images | Build must be ran before push"
	@echo "make update-manifests   # Pushes manifests for all images | Push must be ran before manifests"

## Build x86_64 images
.PHONY: build-x86
build-x86:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache \
	$(X86_IMAGES)

## Build arm64 images
.PHONY: build-arm
build-arm:
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache \
	$(ARM_IMAGES)

## Build all images
.PHONY: build-all
build-all:
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache

## Push x86 images
.PHONY: push-x86
push-x86:
	docker compose push $(X86_IMAGES)

## Push arm images
.PHONY: push-arm
push-arm:
	docker compose push $(ARM_IMAGES)

## Push all images
.PHONY: push-all
push-all: push-x86 push-arm

## Update manifests
.PHONY: update-manifests
update-manifests:
	docker manifest create tetricz/yt-archive:latest tetricz/yt-archive:amd64 tetricz/yt-archive:arm64
	docker manifest create tetricz/openvpn-client:latest tetricz/openvpn-client:amd64 tetricz/openvpn-client:arm64
	docker manifest create tetricz/nextcloud:24 tetricz/nextcloud:amd64
	docker manifest create tetricz/nextcloud:latest tetricz/nextcloud:amd64
	docker manifest create tetricz/jmusicbot:latest tetricz/jmusicbot:amd64 tetricz/jmusicbot:arm64
	docker manifest create tetricz/technitium-dns:latest tetricz/technitium-dns:amd64 tetricz/technitium-dns:arm64
	docker manifest create tetricz/minecraft:latest tetricz/minecraft:amd64 tetricz/minecraft:arm64
	docker manifest create tetricz/minecraft:fabric-auto tetricz/minecraft:fabric-amd64 tetricz/minecraft:fabric-arm64

	docker manifest push tetricz/yt-archive:latest
	docker manifest push tetricz/openvpn-client:latest
	docker manifest push tetricz/nextcloud:24
	docker manifest push tetricz/nextcloud:latest
	docker manifest push tetricz/jmusicbot:latest
	docker manifest push tetricz/technitium-dns:latest
	docker manifest push tetricz/minecraft:latest
	docker manifest push tetricz/fabric-auto:latest

## Do everything
.PHONY: all
all: build-all push-all update-manifests
