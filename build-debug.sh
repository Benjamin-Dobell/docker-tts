#!/usr/bin/env bash

set -e

docker build src -f ./dockerfiles/Dockerfile.debug -t tts-debug
