FROM quay.io/fedora/fedora-bootc:latest@sha256:a521ee9fc074d2f8dae758a1887939a847c636b13c6a8c462272942f697d53d7 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
