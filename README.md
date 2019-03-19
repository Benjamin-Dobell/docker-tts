# Docker Tabletop Simulator

# Build

In order to build you must own Tabletop Simulator in your Steam account.

```bash
./build.sh <steam username> <steam password> [steam guard code]
```

**NOTE:** You'll need to be running at least Docker 18.09.

**Do not redistribute your build!**

Firstly, doing so without permission from Berserk Games would be a violation of Berserk Games' copyright.

Secondly, the built image includes a copy of [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) pre-authenticated to access your Steam account.

## Steam Guard

If your account has Steam Guard enabled, then you'll note that the codes don't last particularly long. When building for the first time your code may expire and your Steam login will fail.

If this occurs, simply execute the command a second time with a new Steam Guard code. Docker will reuse layers from previous builds and therefore attempt to use your Steam Guard code much more quickly on subsequent builds.

# Running

Simply execute:

```bash
docker run tts
```

## Command line arguments

By default we're running Tabletop Simulator with command line arguments `-batchmode -nographics`, which are required to run headless Tabletop Simulator.

However, if you wish to pass through additional arguments you may append them to `docker run`.

e.g. To enable verbose Unity logging you'd run Tabletop Simulator with:

```bash
docker run -it tts -log
```

## Updating

By default, this image will try update Tabletop Simulator on launch. If you wish to skip updating, then you can execute the image as follows:

```bash
docker run -it tts --no-update
```

**Note:** If you're also providing TTS with command line arguments, then `--no-update` must appear first.

## Unity Log

Once Tabletop Simulator is running in a container, logs can be viewed with:

```bash
docker exec -it <container id> tail -f ".config/unity3d/Berserk Games/Tabletop Simulator/Player.log"
```
