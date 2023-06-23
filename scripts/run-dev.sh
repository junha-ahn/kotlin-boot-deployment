#!/bin/sh

cd "$(dirname "$0")" # cd to directory of this script
./gradlew build 
docker-compose up --build