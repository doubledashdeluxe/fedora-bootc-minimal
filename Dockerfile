FROM quay.io/fedora/fedora-bootc:latest@sha256:000c49544a848013dfce7badde3421fd19b96c45f112ccc991e9794d6dbf9e1f as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
