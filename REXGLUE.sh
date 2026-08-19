#!/bin/bash
set -e
clear;

sudo mkdir -p /tmp/-;

if [ -f /tmp/-/linux-amd64/bin/rexglue ]; then
echo "Arquivo rexglue ja existe";

else

echo "baixando rexglue";

wget -P /tmp/- https://github.com/rexglue/rexglue-sdk/releases/download/nightly-20260816-509ed5bf/rexglue-sdk-0.10.0-dev.g509ed5b-linux-amd64.zip;

unzip rexglue-sdk*.zip -d /tmp/-;

sudo rm -rf /tmp/-/rexglue-sdk*.zip;
fi;

sudo mkdir -p /tmp/-/DB;

sudo chmod 777 /tmp/-/linux-amd64/bin/rexglue;

sudo ./tmp/-/linux-amd64/bin/rexglue init --app_name DB --app_root /home/bux/360/DB;

sudo mkdir -p /tmp/-/DB/assets;

sudo mkdir -p /tmp/-/DB/build;

cmake /tmp/-/ -DCMAKE_BUILD_TYPE=Release;

cmake --build /tmp/-/build --target DB_codegen;

make -j$(nproc);