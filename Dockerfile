FROM quay.io/fedora/fedora-bootc:latest@sha256:db4ce967bfd6fd136ce78d898a45fcb6af9e6d00a44cf316037cbb7176b6a9d5 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
