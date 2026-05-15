FROM quay.io/fedora/fedora-bootc:latest@sha256:c6b268a602a5221d31c4e108076ca24efd214d0cc8ac11bb3163f7b0a45e1018 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
