#!/usr/bin/env bash

set -e

BASE_DIR="$(dirname $0)"

if [ "$1" = "--no-update" ]; then
	shift
else
	VALIDATE=

	if [ "$1" = "--validate" ]; then
		shift
		VALIDATE=--validate
	fi

	"$BASE_DIR/update_tts.sh" $VALIDATE
	"$BASE_DIR/apply_patches.sh"
fi

"./tts/Tabletop Simulator.x86_64" -batchmode -nographics "$@"
