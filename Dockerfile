FROM quay.io/fedora/fedora-bootc:latest@sha256:f860d1fd888105845564d2206e5a4c9b7635dd57826fe5c468ca786adeb4d75a as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
