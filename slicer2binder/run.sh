#!/bin/sh

set -x

################################################################################
# Set up headless environment

Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./10.log -config $HOME/xorg.conf $DISPLAY &
sleep 2 

/usr/bin/x11vnc -forever -rfbport $VNCPORT -display :10 -shared -bg -auth none -nopw
sleep 1

################################################################################
# start window manager
# note: last command should not be backgrounded
awesome &

exec "$@"
