#!/usr/bin/env bash

set -e

cd "$PATCH_DIR"
find . -type d -exec mkdir -p "$TTS_DIR/{}" \;
find . -type f -exec cp -f "{}" "$TTS_DIR/{}" \;
