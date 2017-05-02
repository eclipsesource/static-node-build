#!/bin/sh
set -e

DIR=`dirname $0`

set +e
rm -rf node.out/node.linux.x64
mkdir node.out
set -e

set +e
docker rm -v nodebuild.linux.x64
set -e

# Build Linux x64
docker build -t "node-build-linux-x64" $DIR -f linux_builds/Dockerfile.linux.x64
docker run --name nodebuild.linux.x64 node-build-linux-x64
docker cp nodebuild.linux.x64:/build/node/node.linux.x64/ $DIR/node.out/node.linux.x64

