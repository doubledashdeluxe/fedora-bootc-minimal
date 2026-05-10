FROM quay.io/fedora/fedora-bootc:latest@sha256:7daaad39fac6b23bcdfabd3cd09c3057b5884bee323b20424d04991766f1f382 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
