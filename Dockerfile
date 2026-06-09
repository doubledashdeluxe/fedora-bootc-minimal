FROM quay.io/fedora/fedora-bootc:latest@sha256:3c6529ad40fff1ded3be667cc6f0a9fb569b46fdece84ecc0cbc2d06bfdb9739 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
