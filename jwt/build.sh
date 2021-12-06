#!/bin/bash
dockerTag=`jq -r .dockerTag ../config.json`
docker build --build-arg HT_USER=$(id -un) -t $dockerTag/jwt .