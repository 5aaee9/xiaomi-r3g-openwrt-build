FROM debian:stretch-slim
ARG GITHUB_TOKEN

COPY overlay /overlay

RUN apt-get update && \
    apt-get install git make wget sudo \
        build-essential libssl-dev libncurses5-dev unzip \
        subversion mercurial libncurses5-dev zlib1g-dev gawk -y && \
    useradd -m openwrt && \
    chmod -R 777 /overlay && \
    echo $GITHUB_TOKEN >> /github-token && \
    chmod 777 /github-token && \
    sudo -u openwrt bash /overlay/build.sh
