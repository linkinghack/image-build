FROM linkinghack/vm-rootfs:k124-0 as rootfs

FROM alpine as converter
RUN apk add --no-cache qemu-img e2fsprogs
COPY --from=rootfs /rootfs /rootfs
RUN truncate -s 10G /rootfs.raw \
   && mkfs.ext4 -d /rootfs /rootfs.raw \
   && qemu-img convert -f raw -O qcow2 /rootfs.raw /rootfs.qcow2

FROM scratch
COPY --from=converter --chown=107:107 /rootfs.qcow2 /disk/rootfs.qcow2
