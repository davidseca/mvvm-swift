#!/bin/sh

PROJECT_DIR=mvvm-swift-dev
PODS_ROOT=Pods
swiftgen=$PODS_ROOT/SwiftGen/bin/swiftgen

twine generate-all-localization-files i18n.twine $PROJECT_DIR --tags ios --untagged --format apple

if which $swiftgen >/dev/null; then
    $swiftgen
else
    echo "can't run swiftgen" >&2
    exit 1
fi
