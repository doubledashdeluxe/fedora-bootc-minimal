FROM quay.io/fedora/fedora-bootc:latest@sha256:e4fbc514e652189defe3e7b546649f095efc33c2bb0cc1fc54651fa10c52293b as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
