#!/bin/bash
for folder in $BASE_SOURCE*/ ; do
    echo "Building image in $BASE_SOURCE/$folder"
    cd $folder
    bash ./build.sh
    cd ..
done