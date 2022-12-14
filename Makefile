X86_IMAGES := yt-archive-x86 openvpn-client-x86 nextcloud-x86 jmusicbot-x86 technitium-dns-server-x86 minecraft-general-x86 fabric-auto-x86
ARM_IMAGES := yt-archive-arm openvpn-client-arm jmusicbot-arm technitium-dns-server-arm minecraft-general-arm fabric-auto-arm
IMAGE="" # Set this to the image you want to build (e.g. yt-archive-x86)

NC_MANIFEST:= tetricz/nextcloud:25-amd64
YT_MANIFEST:= tetricz/yt-archive:amd64 tetricz/yt-archive:arm64
TD_MANIFEST := tetricz/technitium-dns:amd64 tetricz/technitium-dns:arm64
MC_MANIFEST := tetricz/minecraft:amd64 tetricz/minecraft:arm64
FBR_MANIFEST := tetricz/minecraft:fabric-amd64 tetricz/minecraft:fabric-arm64
VPN_MANIFEST := tetricz/openvpn-client:amd64 tetricz/openvpn-client:arm64

## Echo options
.PHONY: help
help:
	@echo "This depends on the buildx engine for cross architecture builds."
	@echo ""
	@echo "Options:"
	@echo "make build IMAGE=yt-archive-x86		# Build a specific image"
	@echo "make build-x86	       				# Build x86_64 images"
	@echo "make build-arm	       				# Build arm64 images"
	@echo "make build-all 	       				# Builds all images"
	@echo "make push-x86	       				# Push x86_64 images"
	@echo "make push-arm	       				# Push arm64 images"
	@echo "make push-all  	       				# Pushes all images | Build must be ran before push"
	@echo "make update-manifests   				# Pushes manifests for all images | Push must be ran before manifests"
	@echo "make clean	           				# Removes all images"

.PHONY: nextcloud
nextcloud:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	nextcloud-x86
	docker compose push nextcloud-x86
	docker manifest create tetricz/nextcloud:latest $(NC_MANIFEST) --amend
	docker manifest push tetricz/nextcloud:latest
	docker manifest rm tetricz/nextcloud:latest

.PHONY: yt-archive
yt-archive:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	yt-archive-x86
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	yt-archive-arm
	docker compose push yt-archive-x86 yt-archive-arm
	docker manifest create tetricz/yt-archive:latest $(YT_MANIFEST) --amend
	docker manifest push tetricz/yt-archive:latest
	docker manifest rm tetricz/yt-archive:latest

.PHONY: techdns
techdns:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	technitium-dns-server-x86
# Currently build the arm image on a raspberry pi, then push it and pull here for manifest
# https://github.com/NuGet/Home/issues/12227
	docker compose pull technitium-dns-server-arm
#	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
#	docker compose build --no-cache \
#	technitium-dns-server-arm
	docker compose push technitium-dns-server-x86 technitium-dns-server-arm
	docker manifest create tetricz/technitium-dns:latest $(TD_MANIFEST) --amend
	docker manifest push tetricz/technitium-dns:latest
	docker manifest rm tetricz/technitium-dns:latest

.PHONY: minecraft
minecraft:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	minecraft-general-x86 fabric-auto-x86
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	minecraft-general-arm fabric-auto-arm
	docker compose push minecraft-general-x86 minecraft-general-arm fabric-auto-x86 fabric-auto-arm
	docker manifest create tetricz/minecraft:latest $(MC_MANIFEST) --amend
	docker manifest create tetricz/minecraft:fabric-auto $(FBR_MANIFEST) --amend
	docker manifest push tetricz/minecraft:latest
	docker manifest push tetricz/minecraft:fabric-auto
	docker manifest rm tetricz/minecraft:latest
	docker manifest rm tetricz/minecraft:fabric-auto


.PHONY: openvpn
openvpn:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	openvpn-client-x86
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	openvpn-client-arm
	docker compose push openvpn-client-x86 openvpn-client-arm
	docker manifest create tetricz/openvpn-client:latest $(VPN_MANIFEST) --amend
	docker manifest push tetricz/openvpn-client:latest
	docker manifest rm tetricz/openvpn-client:latest

.PHONY: build
build:
	@echo "Building $(IMAGE)"
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --no-cache \
	$(IMAGE)


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
build-all: build-x86 build-arm

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
## All images must be pushed before manifests can be updated
.PHONY: update-manifests
update-manifests:
	docker manifest create tetricz/yt-archive:latest tetricz/yt-archive:amd64 tetricz/yt-archive:arm64 --amend
	docker manifest create tetricz/openvpn-client:latest tetricz/openvpn-client:amd64 tetricz/openvpn-client:arm64 --amend
	docker manifest create tetricz/nextcloud:latest $(NC_MANIFEST) --amend
	docker manifest create tetricz/jmusic-bot:latest tetricz/jmusic-bot:amd64 tetricz/jmusic-bot:arm64 --amend
	docker manifest create tetricz/technitium-dns:latest tetricz/technitium-dns:amd64 tetricz/technitium-dns:arm64 --amend
	docker manifest create tetricz/minecraft:latest tetricz/minecraft:amd64 tetricz/minecraft:arm64 --amend
	docker manifest create tetricz/minecraft:fabric-auto tetricz/minecraft:fabric-amd64 tetricz/minecraft:fabric-arm64 --amend

	docker manifest push tetricz/yt-archive:latest
	docker manifest push tetricz/openvpn-client:latest
	docker manifest push tetricz/nextcloud:latest
	docker manifest push tetricz/jmusic-bot:latest
	docker manifest push tetricz/technitium-dns:latest
	docker manifest push tetricz/minecraft:latest
	docker manifest push tetricz/minecraft:fabric-auto

	docker manifest rm tetricz/yt-archive:latest
	docker manifest rm tetricz/openvpn-client:latest
	docker manifest rm tetricz/nextcloud:latest
	docker manifest rm tetricz/jmusic-bot:latest
	docker manifest rm tetricz/technitium-dns:latest
	docker manifest rm tetricz/minecraft:latest
	docker manifest rm tetricz/minecraft:fabric-auto

.PHONE: clean
clean:
	docker buildx prune -fa
	docker system prune -fa

## Do everything
.PHONY: all
all: build-all push-all update-manifests clean
