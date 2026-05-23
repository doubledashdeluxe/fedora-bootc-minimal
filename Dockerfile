FROM quay.io/fedora/fedora-bootc:latest@sha256:adb982e485d608f8809bd2132d411f6852ca6d0b52240d3ac3e10a161688b306 as builder
RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=minimal /target-rootfs

FROM scratch
COPY --from=builder /target-rootfs/ /

RUN bootc container lint

LABEL containers.bootc 1
LABEL ostree.bootable 1
ENV container=oci
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
