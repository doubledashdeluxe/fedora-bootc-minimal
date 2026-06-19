FROM quay.io/fedora/fedora-bootc:latest@sha256:5cb3f1ce33bb0663effecf6b278dae5c91a97f4ab0b5dddd8a883ba9a9f6b354 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
