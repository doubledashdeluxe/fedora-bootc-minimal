FROM quay.io/fedora/fedora-bootc:latest@sha256:87c9d9a142c824c682ef776c119f9de8c5c22155f6d5546532ac93ab8c842c07 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
