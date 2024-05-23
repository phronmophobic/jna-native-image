#!/bin/bash

set -x

git config --global --add safe.directory /repo
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

source bashrc

apt update
apt install -y cmake gcc libz-dev make tig vim wget

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

set +x
