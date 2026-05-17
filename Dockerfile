FROM quay.io/fedora/fedora-bootc:latest@sha256:efcbfada8a0d0c48ce38785a232928a6f35ca38fa3027f7bcdde79dea88c1d18 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
