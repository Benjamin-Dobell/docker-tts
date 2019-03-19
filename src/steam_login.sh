#!/usr/bin/env bash

set -e

source /run/secrets/steam-credentials

(timeout 30 steamcmd.sh +login "$STEAM_USER" "$STEAM_PASSWORD" "$STEAM_GUARD" +exit) || (echo "Steam login failed"; exit 1;)
