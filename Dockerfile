FROM quay.io/fedora/fedora-bootc:latest@sha256:9288b4c6660c7bbd4872b6ae1478815a57d196db94488c3d148bbc0407b7e428 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
