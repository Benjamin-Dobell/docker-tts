#!/usr/bin/env bash

CONTAINER_ID=$(docker ps -q  --filter ancestor=tts)
docker exec -it "$CONTAINER_ID" tail -f -n +1 ".config/unity3d/Berserk Games/Tabletop Simulator/Player.log"

