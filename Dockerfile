FROM quay.io/fedora/fedora-bootc:latest@sha256:a364327aaf2b69a64493ddc6af73ae81300a37a0d59cafa9fb49c31344861053 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
