FROM quay.io/fedora/fedora-bootc:latest@sha256:06646dc9e022dc2a67590163f485956defafde8bf4982c3a8142ffbfd17d0707 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
