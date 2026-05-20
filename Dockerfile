FROM quay.io/fedora/fedora-bootc:latest@sha256:a999ba981d2d374b08eb831db6ae63e729d1600a046a0395cac60cdda29282f5 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
