#!/bin/bash

set -e
set -x

native-image --report-unsupported-elements-at-runtime \
             --no-fallback \
             -J-Dclojure.compiler.direct-linking=true \
             -H:ReflectionConfigurationFiles=config/reflect-config.json \
             -H:JNIConfigurationFiles=config/jni-config.json \
             -H:ResourceConfigurationFiles=config/resource-config.json \
             -jar ./target/jna-0.1.0-standalone.jar \
             -H:Name=./target/jna
