FROM quay.io/fedora/fedora-bootc:latest@sha256:a7f0ccdc982acf78351fc3f425729d1f45e2779b69201350ebff207730ab3a29 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
