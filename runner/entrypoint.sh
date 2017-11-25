#!/usr/bin/env bash

PROTOBUF_VER=v3.3.2

git clone https://github.com/google/protobuf.git || exit 1
cd protobuf || exit 1
git checkout tags/$PROTOBUF_VER -b pb_build || exit 1
./autogen.sh || exit 1
./configure || exit 1
make -j 4 || exit 1
make check || exit 1
make install || exit 1
ldconfig || exit 1
make clean || exit 1
cd ..
rm -r protobuf || exit 1
go get google.golang.org/grpc || exit 1
go get github.com/golang/protobuf/protoc-gen-go || exit 1
go get -u github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway || exit 1
go get -u github.com/gengo/grpc-gateway/protoc-gen-swagger || exit 1
go get -u github.com/golang/protobuf/protoc-gen-go || exit 1
