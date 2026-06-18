FROM quay.io/fedora/fedora-bootc:latest@sha256:e23805231218ecd1b98ee9ddf77a12661ceb44fcef74b4492fdb2e48d9d4d083 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
