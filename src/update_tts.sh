#!/usr/bin/env bash

VALIDATE=

if [ "$1" = "--validate" ]; then
	VALIDATE="validate"
fi

steamcmd.sh +login "$STEAM_USER" \
	+force_install_dir "$TTS_DIR" \
	+app_update 286160 $VALIDATE \
	+quit
