#!/bin/bash

MCL_VERSION=ce4ab47
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

tree -d ../app
