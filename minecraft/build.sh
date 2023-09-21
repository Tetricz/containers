#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "Building images"
docker buildx build --platform=linux/amd64 -t tetricz/minecraft:amd64 main-general/. --load

docker buildx build --platform=linux/amd64 -t tetricz/ferium:amd64 ferium/. --load

docker buildx build --platform=linux/amd64 -t tetricz/velocity:amd64 velocity/. --load

echo -e "Pushing images"
docker push tetricz/minecraft:amd64

docker push tetricz/ferium:amd64

docker push tetricz/velocity:amd64

echo -e "Creating manifest"
docker manifest create tetricz/minecraft:latest tetricz/minecraft:amd64
docker manifest push tetricz/minecraft:latest
docker manifest rm tetricz/minecraft:latest

docker manifest create tetricz/ferium:latest tetricz/ferium:amd64
docker manifest push tetricz/ferium:latest
docker manifest rm tetricz/ferium:latest

docker manifest create tetricz/velocity:latest tetricz/velocity:amd64
docker manifest push tetricz/velocity:latest
docker manifest rm tetricz/velocity:latest

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
