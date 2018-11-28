#!/bin/bash

set -ex

################################################################################
# Set up headless environment

Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./10.log -config $HOME/xorg.conf $DISPLAY &
sleep 2 

#/usr/bin/x11vnc -forever -rfbport $VNCPORT -display :10 -shared -bg -auth none -nopw
#sleep 1

################################################################################
# start window manager
awesome &

################################################################################
# this needs to be last
exec "$@"
