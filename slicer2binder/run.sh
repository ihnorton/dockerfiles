#!/bin/sh

set +x

################################################################################
# Set up headless environment

Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./10.log -config $HOME/xorg.conf $DISPLAY &
sleep 2 

/usr/bin/x11vnc -forever -rfbport $VNCPORT -display :10 -shared -bg -auth none -nopw
sleep 1

################################################################################
# launch jupyter
# HACK need this until linux build and packaging path is fixed
# note: --ip=0.0.0.0 is to avoid bind errors inside container

# HACK pending linux build fix
export LD_LIBRARY_PATH=$HOME/.config/NA-MIC/Extensions-27480/SlicerJupyter/lib64/
jupyter notebook --no-browser --port=$JUPYTERPORT --ip=0.0.0.0 &

################################################################################
# start window manager
# note: last command should not be backgrounded
awesome
