FROM quay.io/fedora/fedora-bootc:latest@sha256:ec9fb918dfef9b86332335fc428d2aad05e9dc34ed70b5c4b220d3d1a5ea49cb as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
