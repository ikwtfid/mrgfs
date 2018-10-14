FROM ubuntu:16.04

ADD https://github.com/trapexit/mergerfs/releases/download/2.24.2/mergerfs_2.24.2.ubuntu-xenial_amd64.deb /tmp/mergerfs.deb
COPY ./entrypoint /entrypoint

RUN chmod +x /entrypoint && dpkg -i /tmp/mergerfs.deb && rm /tmp/mergerfs.deb

ENTRYPOINT ["/entrypoint"]
ENV MERGERFS_OPTS="-o defaults,allow_other,use_ino,xattr=notsup,dropcacheonclose,hard_remove,moveonenospc=true,minfreespace=10G,fsname=mergedmedia,category.action=all,category.create=epff,category.search=newest" MERGERFS_SRC="/mnt/disk*" MERGERFS_DEST="/mnt/data"

HEALTHCHECK CMD ["ls /mnt/data"]
