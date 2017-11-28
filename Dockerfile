FROM scratch

ADD build/rootfs.tar.gz /

ENTRYPOINT ["protoc"]
