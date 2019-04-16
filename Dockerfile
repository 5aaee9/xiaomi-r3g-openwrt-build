FROM debian:stretch-slim

COPY overlay /overlay

RUN apt-get update && \
    apt-get install git make wget \
        build-essential libssl-dev libncurses5-dev unzip \
        subversion mercurial libncurses5-dev zlib1g-dev gawk -y && \
    git clone https://github.com/openwrt/openwrt.git -b openwrt-18.06 && \
    cd openwrt && \
    cp -rf /overlay trunk && \
    cd trunk && \
    ../scripts/feeds update -a && \
    make -j8 && \
    ls bin
