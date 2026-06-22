FROM quay.io/fedora/fedora-bootc:latest@sha256:dfa9bfb93622c0112aa209ec5a4b5ae650b114d122e199ae4ee0e6f3b31238c8 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
