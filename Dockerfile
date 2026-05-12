FROM quay.io/fedora/fedora-bootc:latest@sha256:1ed7c0aea29cea4f25c31656fcc4fc55bc2ef8ae8db0b6fc2264332e60abb327 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
