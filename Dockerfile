FROM quay.io/fedora/fedora-bootc:latest@sha256:6620b77c782a1e4848bb9b7dad2fb37ea2b0502904cb2a41bb91801fb15fc4f5 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
