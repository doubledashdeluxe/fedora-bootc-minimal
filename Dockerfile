FROM quay.io/fedora/fedora-bootc:latest@sha256:6da3de90148a7091053fa1e5fc7a0d92349348bde198d48d8d7e4c11fa73046e as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
