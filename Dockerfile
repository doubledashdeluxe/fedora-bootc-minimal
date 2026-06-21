FROM quay.io/fedora/fedora-bootc:latest@sha256:ce93d14f04687c60f88ed76ae7395a9fad671063a8e972592bdcc2c0bdd82fa8 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
