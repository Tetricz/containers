#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "Building images"
docker buildx build --platform=linux/amd64 -t tetricz/yt-archive:amd64 . --load
docker buildx build --platform=linux/arm64 -t tetricz/yt-archive:arm64 . --load

echo -e "Pushing images"
docker push tetricz/yt-archive:amd64
docker push tetricz/yt-archive:arm64

echo -e "Creating manifest"
docker manifest create tetricz/yt-archive:latest tetricz/yt-archive:amd64
docker manifest push tetricz/yt-archive:latest
docker manifest rm tetricz/yt-archive:latest

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