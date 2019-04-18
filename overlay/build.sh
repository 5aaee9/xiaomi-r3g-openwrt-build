#!/bin/sh
set -e

cd ~
git clone https://github.com/openwrt/openwrt.git -b openwrt-18.06
cd openwrt
./scripts/feeds install -a
./scripts/feeds update -a
cp -rf /overlay/.config .

echo "CPU Cores: "`grep -c ^processor /proc/cpuinfo`

make -j`grep -c ^processor /proc/cpuinfo` V=99
tar zcvf bin.tgz bin
