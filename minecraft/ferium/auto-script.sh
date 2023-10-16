#!/bin/bash

if [ -d ! "/minecraft/$1-scripts" ]; then
    mkdir /minecraft/$1-scripts
fi

echo -e "Loading $1-upgrade scripts..."
echo -e "Container-Dir: <minecraft-volume>/$1-scripts/"

for file in $(ls $1-scripts | grep -E ".*\.sh");
do
    chmod +x /minecraft/$1-scripts/$file
    echo -e "Loading script: $file"
    source /minecraft/$1-scripts/$file
done
