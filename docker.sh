#!/bin/bash

set -x

echo 'set exrc' >> /root/.vimrc

git config --global --add safe.directory /repo
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

apt update
apt install -y \
  bash-completion \
  cmake \
  curl \
  emacs-nox \
  g++ \
  gcc \
  libz-dev \
  make \
  tig \
  vim \
  wget \
  xz-utils \

curl -sSL yamlscript.org/install | bash

cd /

wget https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz
tar xf graalvm-jdk-21_linux-x64_bin.tar.gz
mv graalvm-jdk-21.* graalvm

cd /repo

source bashrc

make run

# clojure -T:build uber
# ./compile.sh
# ./target/jna

chown -R --reference=Makefile .

set +x
