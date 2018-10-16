FROM slicer/slicer-base

RUN yum install -yq libuuid-devel

RUN cd /usr/src && \
    git clone --depth=1 https://github.com/Slicer/Slicer && \
    /usr/src/Slicer-build/BuildSlicer.sh

RUN cd /usr/src/Slicer-build && \
    git clone https://github.com/Slicer/SlicerJupyter && \
    mkdir SlicerJupyter-build && \
    cd SlicerJupyter-build && \
    cmake -DSlicer_DIR=../Slicer-build ../SlicerJupyter -GNinja && \
    ninja -j$(nproc) && cd inner-build && ninja package
