#!/bin/sh
set -e

cd ~
mkdir git-release
cd git-release
wget https://github.com/aktau/github-release/releases/download/v0.7.2/linux-amd64-github-release.tar.bz2 -O github-release.tar.bz2
tar jxvf github-release.tar.bz2
mv bin/linux/amd64/github-release ~
cd ~
rm -rf git-release

git clone https://github.com/openwrt/openwrt.git -b openwrt-18.06
cd openwrt
./scripts/feeds install -a
./scripts/feeds update -a
cp -rf /overlay/.config .

echo "CPU Cores: "`grep -c ^processor /proc/cpuinfo`

make -j`grep -c ^processor /proc/cpuinfo` V=99
tar zcvf bin.tgz bin

GITHUB_TOKEN=`cat /github-token` ~/github-release upload \
    --user Indexyz \
    --repo xiaomi-r3g-openwrt-build \
    --tag v0.1.0 \
    --name bin.tgz \
    --file bin.tgz
