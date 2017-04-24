#!/bin/sh
set -e

DIR=`dirname $0`

rm -rf node.out
mkdir node.out
mkdir node.out/mac
mkdir node.out/mac/x64

set +e
docker rm -v nodebuild.mac.x64
set -e

# Build Android ARM
docker build -t "node-build-mac-x64" $DIR -f Dockerfile.mac.x64 --build-arg node_version=v7.4.0
docker run --name nodebuild.mac.x64 node-build-mac-x64
docker cp nodebuild.mac.x64:/build/node/out/Release/obj.target/deps/v8/src $DIR/node.out/mac/x64/

# Copy the header files
docker cp nodebuild.mac.x64:/build/node/deps $DIR/node.out/
