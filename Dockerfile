FROM debian:stretch-slim

COPY overlay /overlay

RUN apt-get update && \
    apt-get install git make wget \
        build-essential libssl-dev libncurses5-dev unzip \
        subversion mercurial libncurses5-dev zlib1g-dev gawk -y && \
    git clone https://github.com/openwrt/openwrt.git -b openwrt-18.06 && \
    cd openwrt && \
    ./scripts/feeds install -a  && \
    ./scripts/feeds update -a && \
    cp -rf /overlay/.config . && \
    make V=99 && \
    find bin
