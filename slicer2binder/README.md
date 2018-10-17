# Intro

Dockerfile to run [SlicerJupyter](https://github.com/Slicer/SlicerJupyter), a Jupyter kernel for
[3D Slicer](www.slicer.org).

# Running on binderhub

This image was created to facilitate use of SlicerJupyter on [binder](https://www.mybinder.org). Notebook
functionality is supported, VNC functionality is not yet supported.

[![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/ihnorton/SlicerNotebooks/master)

# Running locally

Docker must be launched with several `-p` arguments in order to expose the notebook server and VNC ports:

    > docker build . -t slicerjupyter
    > docker run -p 8888:8888 -p49053:49053 -ti slicerjupyter /bin/bash

Now connect to `localhost:8888` in a browser, or `vnc://localhost:49053` in a VNC viewer.
 
# Resources

- https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html#preparing-your-dockerfile
- https://sebasguts.github.io/GAPDaysBinderTutorial/#/What-is-Binder
