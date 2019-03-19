# syntax = docker/dockerfile:1.0-experimental
FROM debian:buster-slim

RUN set -x \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		ca-certificates \
		lib32stdc++6 \
		wget \
	&& useradd -m steam \
    && su steam -c \
	    "mkdir -p /home/steam/steamcmd \
		    && cd /home/steam/steamcmd \
			&& wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -" \
    && apt-get clean

USER steam

ENV PATH="/home/steam/steamcmd:${PATH}"
WORKDIR /home/steam

ARG STEAM_USER
ENV STEAM_USER=${STEAM_USER}

COPY steam_login.sh .

RUN steamcmd.sh +exit
RUN --mount=type=secret,id=steam-credentials,mode=0444 ./steam_login.sh

ENV TTS_DIR=/home/steam/tts

COPY update_tts.sh .
RUN ./update_tts.sh --validate

ENV PATCH_DIR=/home/steam/patches

COPY apply_patches.sh .
COPY patches /home/steam/patches
RUN ./apply_patches.sh

COPY tts.sh .

ARG STEAM_REAUTH_DATE
ENV STEAM_REAUTH_DATE=${STEAM_REAUTH_DATE}
RUN --mount=type=secret,id=steam-credentials,mode=0444 [ -z "$STEAM_REAUTH_DATE" ] || ./steam_login.sh

ENTRYPOINT ["/home/steam/tts.sh"]
