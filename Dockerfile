FROM quay.io/fedora/fedora-bootc:latest@sha256:5c8f1ddaaf5dbaf1c35b6221bdf0861cd23bbd70339e258666c14659d59a970b as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
