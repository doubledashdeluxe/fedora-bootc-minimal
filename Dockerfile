FROM quay.io/fedora/fedora-bootc:latest@sha256:e2bb9b732b205821caabc3cb6aaca4d95ab043febf2d96c4363c97d6e5cff20e as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
