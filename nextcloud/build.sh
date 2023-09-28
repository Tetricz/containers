#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "Building images"
docker buildx build --build-arg NC_VERSION=27 --platform=linux/amd64 -t tetricz/nextcloud:amd64-27 . --load
docker buildx build --build-arg NC_VERSION=26 --platform=linux/amd64 -t tetricz/nextcloud:amd64-26 . --load
docker buildx build --build-arg NC_VERSION=25 --platform=linux/amd64 -t tetricz/nextcloud:amd64-25 . --load

echo -e "Pushing images"
docker push tetricz/nextcloud:amd64-27
docker push tetricz/nextcloud:amd64-26
docker push tetricz/nextcloud:amd64-25

echo -e "Creating manifest"
docker manifest create tetricz/nextcloud:latest tetricz/nextcloud:amd64-27 --amend
docker manifest push tetricz/nextcloud:latest
docker manifest rm tetricz/nextcloud:latest

echo -e "Do you want to clean the file system?"
echo -e "Warning this will run ${RED}docker system prune -fa${NC}"
read -p "Continue (y/N)?" choice

if [[ $choice =~ ^[Yy]$ ]]; then
    echo -e "Cleaning docker system"
    docker system prune -fa
fi

if [[ $choice =~ ^[Nn]$ ]]; then
    echo -e "Skipping cleaning docker system"
else
    echo -e "Skipping cleaning docker system"
fi