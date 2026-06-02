FROM quay.io/fedora/fedora-bootc:latest@sha256:f6ad3e641ca297cd47e37c47820f7bb1d4f50997030dd42df11d28d43d6fd4d2 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
