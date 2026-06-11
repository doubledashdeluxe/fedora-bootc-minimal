FROM quay.io/fedora/fedora-bootc:latest@sha256:a1b888e813eb23818f40f506714a1460c55099025e246dc3120f9ac1e14e0833 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
