# Spyglass Plugin

## Description

This plugin runs the [Spyglass](https://github.com/roamingthings/spyglass) webcam streaming service as a DSF plugin. The main `spyglass.conf` file is accessible via `0:/sys/spyglass.conf`.

Depending on your choice of camera, extra customizations may be required.

## Setup in DWC

To configure this service in DWC, go to the `Settings` -> `General` page and make the following changes:

- Set `Webcam URL` to `http://[HOSTNAME]:8080/stream`
- Set `Webcam update interval (in ms)` to `0`
- Go to the `Job` -> `Webcam` page to see your live stream

## Build instructions

Create a ZIP file of every file in the `src` directory and make sure `plugin.json` is at the root level. Once created, the ZIP can be installed as a third-party plugin.
If a Debian package is supposed to be generated, check out to the `pkg/build.sh` script.

## Logging

Unfortunately this service outputs info and warning log messages even if the log level is initially set, so by default this plugin's configuration suppresses all the log messages and only sends them to the `duetpluginservice` journal log.

### Checking the journald log (recommended way)

To view the log of the Spyglass service, open a Linux console (or connect over SSH) and run

```
journalctl -u duetpluginservice -f
```

Then restart the Motion Webcam Server plugin and look for potential errors.


### Modify plugin manifest to see all messages in DWC

To see all the output messages from the Spyglass service directly in DWC, open `plugin.json` and set `sbcOutputRedirected` from `false` to `true`. Then build the plugin again and overwrite the existing installation.
Once the plugin is restarted, all the log messages are written to the DWC console.
