#!/bin/sh

PLATFORM=$1
NAME=${2:-unnamed}

if [ -z $PLATFORM ]; then
    echo "Platform not specified"
    exit
fi

# Mac should already be a zip file
if [ "$PLATFORM" != "mac" ]; then
    cd build
    mv $PLATFORM $NAME && zip -r $NAME-$PLATFORM.zip $NAME
fi