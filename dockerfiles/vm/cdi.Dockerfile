FROM linkinghack/vm-rootfs:k125-4 AS rootfs
RUN apk add qemu-img
RUN /entrypoint.sh /rootfs.raw 2G
RUN qemu-img convert -f raw -O qcow2 /rootfs.raw rootfs.qcow2

FROM kubevirt/container-disk-v1alpha
COPY --from=rootfs /rootfs.qcow2 /disk/rootfs.qcow2
