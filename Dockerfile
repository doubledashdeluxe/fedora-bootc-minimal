FROM quay.io/fedora/fedora-bootc:latest@sha256:cf43a66c464a71c08f479a834716d54a94830001aecaef7e9e23d7c5ef1c4dfd as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
