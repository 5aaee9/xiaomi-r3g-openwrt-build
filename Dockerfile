FROM debian:stretch-slim

COPY overlay /overlay

RUN echo $GITHUB_TOKEN && \
    exit 0 && \
    apt-get update && \
    apt-get install git make wget sudo \
        build-essential libssl-dev libncurses5-dev unzip \
        subversion mercurial libncurses5-dev zlib1g-dev gawk -y && \
    useradd -m openwrt && \
    chmod -R 777 /overlay && \
    echo $GITHUB_TOKEN >> /github-token && \
    chmod 777 /github-token && \
    sudo -u openwrt bash /overlay/build.sh
