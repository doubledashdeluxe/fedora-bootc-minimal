FROM quay.io/fedora/fedora-bootc:latest@sha256:0bf9cfbe62aa34248d4c747a99a30701d9efcb0b7cbd5a362fc1a090fa40e55c as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
