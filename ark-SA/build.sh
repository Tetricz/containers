#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "Creating Builder"
bash -c ../multi-arch.sh
docker buildx create --name pz-multi-arch-builder --bootstrap --use
docker buildx inspect --bootstrap

echo -e "Building images"
docker buildx build --platform=linux/amd64 -t tetricz/ark-ascended:amd64 . --load

echo -e "Pushing images"
docker push tetricz/ark-ascended:amd64

echo -e "Creating manifest"
docker manifest create tetricz/ark-ascended:latest tetricz/ark-ascended:amd64
docker manifest push tetricz/ark-ascended:latest
docker manifest rm tetricz/ark-ascended:latest

echo -e "Do you want to clean the file system?"
echo -e "Warning this will run ${RED}docker system prune -fa${NC}"
read -p "Continue (y/N)?" choice

if [[ $choice =~ ^[Yy]$ ]]; then
    echo -e "Cleaning docker system"
    docker system prune -fa
fi

if [[ $choice =~ ^[Yy]$ ]]; then
    echo -e "Cleaning docker system"
    docker system prune -fa
    echo -e "Removing Builder"
    docker buildx rm pz-multi-arch-builder
    exit 0
fi

echo -e "Skipping cleaning docker system"
