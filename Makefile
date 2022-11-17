## Echo options
echo: setup-buildx
	echo "Options:"
	echo "make build-x86	 # Build x86_64 images"
	echo "make build-arm	 # Build arm64 images"
	echo "make build-all 	 # Builds all images"
	echo "make push-x86	 	 # Push x86_64 images"
	echo "make push-arm	 	 # Push arm64 images"
	echo "make push-all  	 # Pushes all images | Build must be ran before push"
	echo "update-manifests   # Pushes manifests for all images | Push must be ran before manifests"

## Setup buildx
setup-buildx:
	docker buildx create --name tetricz-containers --use

## Build x86_64 images
build-x86:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache \
	yt-archive-x86 openvpn-client-x86 nextcloud-x86 jmusicbot-x86 technitium-dns-server-x86 minecraft-general-x86 fabric-auto-x86

## Build arm64 images
build-arm:
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache \
	yt-archive-arm openvpn-client-arm jmusicbot-arm technitium-dns-server-arm minecraft-general-arm fabric-auto-arm

## Build all images
build-all:
	DOCKER_DEFAULT_PLATFORM=linux/arm64 COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 \
	docker compose build --parallel --no-cache

## Push x86 images
push-x86:
	docker push tetricz/yt-archive-x86
	docker push tetricz/openvpn-client-x86
	docker push tetricz/nextcloud-x86
	docker push tetricz/jmusicbot-x86
	docker push tetricz/technitium-dns-server-x86
	docker push tetricz/minecraft-general-x86
	docker push tetricz/fabric-auto-x86

## Push arm images
push-arm:
	docker push tetricz/yt-archive-arm
	docker push tetricz/openvpn-client-arm
	docker push tetricz/jmusicbot-arm
	docker push tetricz/technitium-dns-server-arm
	docker push tetricz/minecraft-general-arm
	docker push tetricz/fabric-auto-arm

## Push all images
push-all: push-x86 push-arm

## Update manifests
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
all: build-all push-all update-manifests
