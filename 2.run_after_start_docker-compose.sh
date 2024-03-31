#!/bin/bash
docker network connect main-server_docker-lesson nginxapp
docker network connect main-server_docker-lesson php_fpm
docker-compose restart
