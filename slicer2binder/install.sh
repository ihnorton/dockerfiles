#!/bin/sh

set +x

################################################################################
# need an X server
Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile /tmp/1.log -config /slicer/xorg.conf $DISPLAY &
export XORG_PID=$!
sleep 2

# TODO HACK
export LD_LIBRARY_PATH=/home/sliceruser/.config/NA-MIC/Extensions-27480/SlicerJupyter/lib64/

# Do the extension install
# TODO HACK
/slicer/Slicer-4.9.0-2018-10-14-linux-amd64/Slicer -c 'slicer.app.extensionsManagerModel().installExtension("/slicer/634b0ef-linux-amd64-SlicerJupyter-git4772650-2018-10-03.tar.gz"); slicer.modules.jupyterkernel.updateKernelSpec()'

# Do the kernel install 
/slicer/Slicer-4.9.0-2018-10-14-linux-amd64/Slicer -c 'slicer.modules.jupyterkernel.updateKernelSpec()'

jupyter-kernelspec install /home/sliceruser/.config/NA-MIC/Extensions-27480/SlicerJupyter/share/Slicer-4.9/qt-loadable-modules/JupyterKernel/Slicer-4.9 --replace --user

kill -9 $XORG_PID
rm /tmp/.X10-lock
