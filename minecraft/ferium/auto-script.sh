#!/bin/bash

echo -e "Loading custom bash scripts..."
echo -e "Container-Dir: $(pwd)/scripts/"

for file in $(ls scripts | grep -E ".*\.sh");
do
    echo -e "Loading script: $file"
    source /minecraft/scripts/$file
done