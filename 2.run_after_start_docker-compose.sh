#!/bin/bash
docker network connect main-server_docker-bridged nginxapp
docker network connect main-server_docker-bridged php_fpm
docker network connect main-server_docker-bridged mysql
docker network connect main-server_docker-bridged phpmyadmin
docker-compose restart
