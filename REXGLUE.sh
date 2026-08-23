#!/bin/bash
set -e
clear;

sudo mkdir -p /tmp/-;

if [ -f /tmp/-/linux-*/bin/rexglue ]; then
echo "Arquivo rexglue ja existe";
else
echo "baixando rexglue" && \
wget -P /tmp/- https://github.com/rexglue/rexglue-sdk/releases/download/nightly-20260816-509ed5bf/rexglue-sdk-0.10.0-dev.g509ed5b-linux-amd64.zip && \
unzip /tmp/-/*.zip -d /tmp/- && \
sudo rm -rf /tmp/-/*.zip;
fi;

sudo mkdir -p /tmp/-/DB;

sudo chmod 777 /tmp/-/linux-*/bin/rexglue;

sudo ./tmp/-/linux-*/bin/rexglue init --app_name DB --app_root /tmp/-/DB;

sudo mkdir -p /tmp/-/DB/assets;

sudo mkdir -p /tmp/-/DB/build;

cmake /tmp/-/DB -DCMAKE_BUILD_TYPE=Release;

cmake --build /tmp/-/DB/build --target DB_codegen;

make -j$(nproc);
