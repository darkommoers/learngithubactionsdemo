#!/bin/sh
#
set -e

# wg-quick up wg0
wg-quick up "$@"

echo "[hit enter key to exit] or run 'docker stop <container>'"
# Keep the script running to keep the container alive
# tail -f /dev/null
# while true; do sleep 1; done
# until false; do sleep 1; done
# sleep infinity
# read REPLY
exec /bin/sh -c "trap : TERM INT; read REPLY"
# exec /bin/bash -c "trap - TERM INT; read REPLY"
# exec /bin/sh -c "trap : TERM INT; sleep infinity & wait"
# exec /bin/bash -c "trap - TERM INT; sleep infinity & wait"
# exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1024; done) & wait"
# exec /bin/bash -c "trap - TERM INT; (until false; do sleep 1024; done) & wait"
# /usr/bin/env sh
# /usr/bin/env bash
