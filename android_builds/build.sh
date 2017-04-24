#!/bin/sh
set -e

DIR=`dirname $0`

rm -rf node.out
mkdir node.out
mkdir node.out/android
mkdir node.out/android/x86
mkdir node.out/android/arm

set +e
docker rm -v nodebuild.android.arm
docker rm -v nodebuild.android.x86
set -e

# Build Android ARM
docker build -t "node-build-android-arm" $DIR -f Dockerfile.android.arm --build-arg node_version=v7.4.0
docker run --name nodebuild.android.arm node-build-android-arm
docker cp nodebuild.android.arm:/build/node/out/Release/obj.target/deps/v8/src $DIR/node.out/android/arm/

# Build Android x86
docker build -t "node-build-android-x86" $DIR -f Dockerfile.android.x86 --build-arg node_version=v7.4.0
docker run --name nodebuild.android.x86 node-build-android-x86
docker cp nodebuild.android.x86:/build/node/out/Release/obj.target/deps/v8/src $DIR/node.out/android/x86/

# Copy the header files
docker cp nodebuild.android.x86:/build/node/deps $DIR/node.out/
