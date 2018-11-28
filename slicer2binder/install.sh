#!/bin/sh

set +x

################################################################################
# need an X server
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile /tmp/1.log -config $HOME/xorg.conf $DISPLAY &

# grab the process id in order to control it later
export XORG_PID=$!
# give bg X time to start
sleep 1.2

# Do the extension install
SLICER=Slicer-4.10.0-linux-amd64
$HOME/$SLICER/Slicer --disable-loadable-modules --disable-cli-modules --disable-scripted-loadable-modules \
    -c "slicer.app.extensionsManagerModel().installExtension('SlicerJupyter')"
$HOME/$SLICER/Slicer -c "slicer.modules.jupyterkernel.updateKernelSpec()"

# Do the kernel install 
jupyter-kernelspec install $HOME/.config/NA-MIC/Extensions-27501/SlicerJupyter/share/Slicer-4.9/qt-loadable-modules/JupyterKernel/Slicer-4.9 --replace --user

kill -9 $XORG_PID
rm /tmp/.X10-lock
