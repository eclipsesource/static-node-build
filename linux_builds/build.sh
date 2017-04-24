#!/bin/sh
set -e

DIR=`dirname $0`

rm -rf node.out
mkdir node.out
mkdir node.out/linux
mkdir node.out/linux/x64

set +e
docker rm -v nodebuild.linux.x64
set -e

# Build Linux x64
docker build -t "node-build-linux-x64" $DIR -f Dockerfile.linux.x64 --build-arg node_version=v7.4.0
docker run --name nodebuild.linux.x64 node-build-linux-x64
docker cp nodebuild.linux.x64:/build/node/out/Release/obj.target/deps/v8/src $DIR/node.out/linux/x64

# Copy the header files
docker cp nodebuild.linux.x64:/build/node/deps $DIR/node.out/
