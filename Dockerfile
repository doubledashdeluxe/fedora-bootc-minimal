FROM quay.io/fedora/fedora-bootc:latest@sha256:e231d81004bff535fcc08f1a82a02b8c08ecd3352bfe7f778496f08312c83fe1 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
