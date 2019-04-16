#!/bin/sh
set -e

cd ~
git clone https://github.com/openwrt/openwrt.git -b openwrt-18.06
cd openwrt
./scripts/feeds install -a
./scripts/feeds update -a
cp -rf /overlay/.config .
make -j8 V=99
find bin
