#!/usr/bin/env bash

echo "1 Checking protoc installation"
if ! [ -x "$(command -v protoc)" ]; then
    echo "you do not seem to have the protoc executable on your path"
    echo "we need protoc to generate a service defintion (*.pb file) that envoy can understand"
    echo "download the precompiled protoc executable and place it in somewhere in your systems PATH!"
    echo "goto: https://github.com/protocolbuffers/protobuf/releases/latest"
    echo "choose:"
    echo "       for linux:   protoc-3.6.1-linux-x86_64.zip"
    echo "       for windows: protoc-3.6.1-win32.zip"
    echo "       for mac:     protoc-3.6.1-osx-x86_64.zip"
    exit 1
else
    protoc --version
fi

echo "2 Generate Proto Descriptors"
# generate the reservation_service_definition.pb file that we can pass to envoy so that knows the grpc service
# we want to expose
protoc -I. -Ibuild/extracted-include-protos/main --include_imports \
    --include_source_info \
    --descriptor_set_out=reservation_service_definition.pb \
    src/main/proto/reservation_service.proto

if ! [ $? -eq 0 ]; then
    echo "protobuf compilation failed"
    exit 1
fi

echo "3 Start envoy container"
getenvoy run standard:1.16.2 -- --config-path ./envoy-config.yaml