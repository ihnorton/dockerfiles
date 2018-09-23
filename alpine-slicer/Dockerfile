FROM jamesbrink/opengl:18.0.1

WORKDIR /opt
RUN apk add --no-cache \
    alpine-sdk wget \
    bash \
    build-base \
    cmake \
    wget \
    less # let `git diff` work ootb for debugging

RUN echo http://dl-cdn.alpinelinux.org/alpine/latest-stable/main >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/latest-stable/community >> /etc/apk/repositories
RUN echo http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && apk update

RUN apk add --no-cache \
    qt5-qtbase-dev qt5-qtwebengine-dev qt5-qtmultimedia-dev \
    qt5-qttools-dev qt5-qtbase-sqlite qt5-qtx11extras-dev \
    qt5-qtxmlpatterns-dev qt5-qtsvg-dev \
    libxt-dev libxrender-dev libxcb-dev \
    libxi-dev libsm-dev xcb-util-keysyms \
    xcb-util-image

RUN apk add --no-cache libxml2-dev # VTK's vendored version is missing patch

RUN mkdir build && cd build && \
    cmake ../slicer \
        -DQt5_DIR:PATH=/usr/lib/cmake/Qt5/ \
        -DSlicer_BUILD_EXTENSIONMANAGER_SUPPORT=0 \
        -DSlicer_USE_CTKAPPLAUNCHER=0 \
        -DBUILD_TESTING=0 \
        -DSlicer_BUILD_QT_DESIGNER_PLUGINS=0 \
        -DSlicer_USE_SimpleITK=0 \
        -DVTKv9_EP_ARGS=\"-DVTK_USE_SYSTEM_LIBXML2\"

RUN cd build && make -j16
