#!/bin/bash

MCL_VERSION=`wget -qO- -t1 -T2 "https://api.github.com/repos/iTXTech/mcl-installer/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
# QSIGN_VERSION=`wget -qO- -t1 -T2 "https://api.github.com/repos/MrXiaoM/qsign/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
# Exit if any error occured
set -euxo pipefail


wget "https://github.com/iTXTech/mcl-installer/releases/download/${MCL_VERSION}/mcl-installer-${MCL_VERSION#v}-linux-amd64-musl" -O ./mcl-installer

chmod +x ./mcl-installer

mkdir app && cd app
# 安装临时的 fix-protocol-version 插件
mkdir plugins

"../mcl-installer" << EOF
N
Y
EOF

chmod +x ./mcl

./mcl --update-package net.mamoe:mirai-console --channel     maven-prerelease
./mcl --update-package net.mamoe:mirai-core-all --channel maven-prerelease
./mcl --update-package net.mamoe:mirai-console-terminal --channel maven-prerelease
./mcl --update-package net.mamoe:mirai-api-http --channel stable-v2 --type plugin
./mcl --update-package xyz.cssxsh.mirai:mirai-device-generator --channel stable --type plugin
./mcl --boot-only
./mcl --dry-run
./mcl << EOF
exit
EOF
# https://github.com/MrXiaoM/qsign/releases/download/${QSIGN_VERSION}/qsign-${QSIGN_VERSION#v}-all.zip && unzip qsign-${QSIGN_VERSION#v}-all.zip

tree -d ../app
