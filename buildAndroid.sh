#!/bin/sh
set -e

DIR=`dirname $0`

set +e
rm -rf node.out/node.armeabi-v7a
rm -rf node.out/node.x86
mkdir node.out
set -e

set +e
docker rm -v nodebuild.android.arm
docker rm -v nodebuild.android.x86
set -e

# Build Android ARM
docker build -t "node-build-android-arm" $DIR -f android_builds/Dockerfile.android.arm
docker run --name nodebuild.android.arm node-build-android-arm
docker cp nodebuild.android.arm:/build/node/node.armeabi-v7a/ $DIR/node.out/node.armeabi-v7a

# Build Android x86
docker build -t "node-build-android-x86" $DIR -f android_builds/Dockerfile.android.x86
docker run --name nodebuild.android.x86 node-build-android-x86
docker cp nodebuild.android.x86:/build/node/node.x86/ $DIR/node.out/node.x86
