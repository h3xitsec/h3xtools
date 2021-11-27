#!/bin/bash
dockerTag=`jq -r .dockerTag ../config.json`
docker build -t $dockerTag/metasploit .