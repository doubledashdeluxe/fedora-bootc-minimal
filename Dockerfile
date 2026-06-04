FROM quay.io/fedora/fedora-bootc:latest@sha256:301d6ffcb2c8df88cf5328ec9041b411c740cd528e2d47e3af0f12306a63eef1 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
