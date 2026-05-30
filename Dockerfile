FROM quay.io/fedora/fedora-bootc:latest@sha256:09d0b1223491c3b58ca6977161c20658ccd25d9e525c7e0be3141243ef0b8dd3 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
