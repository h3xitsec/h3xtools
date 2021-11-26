#!/bin/bash
basePath="/home/h3x/work/docker/"
for folder in $basePath*/ ; do
    cd $folder
    bash ./build.sh
    cd $basePath
done