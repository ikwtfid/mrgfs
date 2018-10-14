FROM lsiobase/ubuntu:xenial

RUN apt-get update && apt-get install -y wget unzip

ADD https://github.com/trapexit/mergerfs/releases/download/2.24.2/mergerfs_2.24.2.ubuntu-xenial_amd64.deb /tmp/mergerfs.deb
COPY ./entrypoint /entrypoint

RUN chmod +x /entrypoint && dpkg -i /tmp/mergerfs.deb && rm /tmp/mergerfs.deb

RUN wget -O /tmp/mergefs-tools.zip https://github.com/trapexit/mergerfs-tools/archive/master.zip && unzip /tmp/mergefs-tools.zip -d /tmp/mergefs-tools && chmod +x /tmp/mergefs-tools/mergerfs-tools-master/src/* && cp /tmp/mergefs-tools/mergerfs-tools-master/src/* /usr/local/bin

ENV MERGERFS_OPTS="defaults,allow_other,use_ino,dropcacheonclose=true,hard_remove,moveonenospc=true,minfreespace=10G,fsname=mergedmedia,category.action=all,category.create=ff,category.search=newest" MERGERFS_SRC="/mnt/disk*" MERGERFS_DEST="/mnt/data"

ADD run /etc/services.d/mergerfs/run
ADD finish /etc/services.d/mergerfs/finish
