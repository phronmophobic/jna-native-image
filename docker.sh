#!/bin/bash

set -x

git config --global --add safe.directory /repo

apt update
apt install -y gcc libz-dev make vim wget

cd /

wget https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz
tar xf graalvm-jdk-21_linux-x64_bin.tar.gz
mv graalvm-jdk-21.* graalvm

export JAVA_HOME=/graalvm
export PATH=$JAVA_HOME/bin:$PATH

cd /repo

clojure -T:build uber
./compile.sh
./target/jna

chown -R --reference=docker.sh .
