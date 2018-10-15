#!/bin/sh

su - sliceruser

Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./10.log -config ./xorg.conf :10 &
export DISPLAY=:10

/usr/bin/x11vnc -forever -rfbport 5902 -usepw -display :10 -shared -bg &

awesome &

./Slicer-4.9.0-2018-10-14-linux-amd64/Slicer
