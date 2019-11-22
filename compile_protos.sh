#!/usr/bin/env bash
#genPath=/Users/qqzhao/Library/qqzhao/flutter/.pub-cache/hosted/pub.dartlang.org/protoc_plugin-19.0.1/bin/protoc-gen-dart
rm -rf lib/generated
mkdir lib/generated
protoc --dart_out=lib/generated --plugin=protoc-gen-dart=run_protoc_plugin.sh -Iprotos protos/*.proto
dartfmt -w lib/generated
