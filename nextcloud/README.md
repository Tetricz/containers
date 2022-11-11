# Nextcloud - thirdparty dependencies

[![Docker Image CI](https://github.com/Tetricz/nextcloud-docker/actions/workflows/docker-image.yml/badge.svg?branch=master)](https://github.com/Tetricz/nextcloud-docker/actions/workflows/docker-image.yml)

This is a simple nextcloud container based off the official docker image, but with dependencie built in for thirdparty apps.

## Built-in dependencies for apps

* php-ffi: storj external
* smbclient

## Planned added dependencies

If you have a request, just make an issue or add it yourself and I will review it

## OCC

To utilize occ you will need to run a command on the host or utilize the occ app from inside nextcloud. I recommend running occ using `docker exec -u www-data -it Nextcloud /var/www/html/occ`

## Cronjob

Preferred method is to create a cronjob on the host that checks if the container is running every 5 minutes. If it is run `docker exec -u www-data Nextcloud php cron.php`  

Example script:

``` bash
#!/bin/bash
if [ -f "/var/run/dockerd.pid" ]; then
    echo "Docker is running.... Checking on Nextcloud container"
    if [ "$(docker ps -q -f name=Nextcloud | grep tetricz/nextcloud)" ]; then
        echo "Container is running. Executing cron"
        docker exec -u www-data Nextcloud php cron.php
    else
        echo "Container is not running."
    fi
else
    echo "Docker is not running..."
fi
```
