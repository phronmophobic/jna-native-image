#!/bin/bash

set -e
set -x

native-image \
  --no-fallback \
  --report-unsupported-elements-at-runtime \
  \
  -J-Dclojure.compiler.direct-linking=true \
  \
  -H:Log=registerResource:5 \
  \
  -H:JNIConfigurationFiles=config/jni-config.json \
  -H:ResourceConfigurationFiles=config/resource-config.json \
  -H:ReflectionConfigurationFiles=config/reflect-config.json \
  \
  -jar target/jna-0.1.0-standalone.jar \
  -H:Name=target/jna
