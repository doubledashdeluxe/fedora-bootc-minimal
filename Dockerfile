FROM quay.io/fedora/fedora-bootc:latest@sha256:e3eaca476d25a47aec32f15fc5ee939a15a40d2cf163bc722d0a598d33558484 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
