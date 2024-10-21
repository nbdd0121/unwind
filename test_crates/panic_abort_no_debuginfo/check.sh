#!/usr/bin/env bash
set -o pipefail

# Skip the test if need -Zbuild-std, it somehow doesn't work.
if [ -n "$BUILD_STD" ]; then
    exit 0
fi

export CARGO_TARGET_DIR=$(mktemp -d)
trap "rm -rf $CARGO_TARGET_DIR" EXIT
RUSTFLAGS="-Cpanic=abort -Cdebuginfo=0" ${CARGO:-cargo} build --release $BUILD_STD 2>&1
