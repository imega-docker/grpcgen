#!/usr/bin/env bash

PROTOBUF_VER=v3.3.2

git clone https://github.com/google/protobuf.git || exit 1
cd protobuf || exit 1
git checkout tags/$PROTOBUF_VER -b pb_build -f || exit 1
./autogen.sh || exit 1
./configure || exit 1
make -j 4 || exit 1
make check || exit 1
make install || exit 1
cd ..
rm -r protobuf

# ===================plugins========================

export GOPATH=/go
mkdir -p /go

go get google.golang.org/grpc || exit 1

go get github.com/golang/protobuf/protoc-gen-go || exit 1

go get github.com/gengo/grpc-gateway/protoc-gen-grpc-gateway || exit 1
go get github.com/gengo/grpc-gateway/protoc-gen-swagger || exit 1

go get github.com/gogo/protobuf/protoc-gen-combo || exit 1
go get github.com/gogo/protobuf/protoc-gen-gogo || exit 1
go get github.com/gogo/protobuf/protoc-gen-gogofast || exit 1
go get github.com/gogo/protobuf/protoc-gen-gogofaster || exit 1
go get github.com/gogo/protobuf/protoc-gen-gogoslick || exit 1
go get github.com/gogo/protobuf/protoc-gen-gogotypes || exit 1
go get github.com/gogo/protobuf/protoc-gen-gostring || exit 1
go get github.com/gogo/protobuf/protoc-gen-gofast || exit 1

# ===================dirs========================

mkdir -p $ROOTFS/usr/local/bin
mkdir -p $ROOTFS/usr/local/lib
mkdir -p $ROOTFS/usr/lib

# ===================copies plugins and libs========================

cp /usr/local/bin/* $ROOTFS/usr/local/bin/

cp /go/bin/* $ROOTFS/usr/local/bin/

cp /usr/lib/libstdc\+\+.so.6.0.22 $ROOTFS/usr/lib/libstdc\+\+.so.6.0.22
cp /usr/lib/libgcc_s.so.1 $ROOTFS/usr/lib/libgcc_s.so.1
cp /usr/local/lib/libprotoc.so.13.0.2 $ROOTFS/usr/local/lib/libprotoc.so.13.0.2
cp /usr/local/lib/libprotobuf.so.13.0.2 $ROOTFS/usr/local/lib/libprotobuf.so.13.0.2

# ===================linking========================
cd $ROOTFS/usr/lib
ln -s libstdc\+\+.so.6.0.22 libstdc\+\+.so.6

cd $ROOTFS/usr/local/lib
ln -s libprotobuf.so.13.0.2 libprotobuf.so.13
ln -s libprotoc.so.13.0.2 libprotoc.so.13
