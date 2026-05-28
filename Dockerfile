FROM quay.io/fedora/fedora-bootc:latest@sha256:3ec61e9a639d6e336f472987375c03eb476c4bdd68a63ed09a9d5cf8b7e76ba7 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
