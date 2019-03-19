#!/usr/bin/env bash

set -eE

if [ $# -lt 2 ]; then
	echo "Usage: $0 [--reauthenticate] <steam username> <steam password> [steam guard code]"
	exit 1
fi

BASE_DIR=$(dirname $0)
CREDENTIALS_PATH=$BASE_DIR/.steam-credentials
DOCKERFILE_PATH=$BASE_DIR/dockerfiles/Dockerfile

trap "if [ -f \"$CREDENTIALS_PATH\" ]; then rm \"$CREDENTIALS_PATH\"; fi" ERR

STEAM_REAUTH_DATE=

if [ "$1" = "--reauthenticate" ]; then
	shift
	STEAM_REAUTH_DATE="$(date -R)"
fi

STEAM_USER="$1"
STEAM_PASSWORD="$2"
STEAM_GUARD=""

if [ $# -gt 2 ]; then
	STEAM_GUARD="$3"
fi

cat <<EOF > "$CREDENTIALS_PATH"
STEAM_PASSWORD="$STEAM_PASSWORD"
STEAM_GUARD="$STEAM_GUARD"
EOF

DOCKER_BUILDKIT=1 docker build src -t tts --secret "id=steam-credentials,src=$CREDENTIALS_PATH" -f "$DOCKERFILE_PATH" --build-arg "STEAM_USER=$STEAM_USER" --build-arg "STEAM_REAUTH_DATE=$STEAM_REAUTH_DATE"

rm "$CREDENTIALS_PATH"
