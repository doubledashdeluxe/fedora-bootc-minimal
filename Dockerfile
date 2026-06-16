FROM quay.io/fedora/fedora-bootc:latest@sha256:91dfff0aa0553dfb4d6d8381d459146a246aa290c5212f2350c20e99f46def4f as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
