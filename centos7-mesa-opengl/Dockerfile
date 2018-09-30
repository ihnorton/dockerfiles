# STATUS: nightly doesn't run on CentOS6

FROM centos:7

# need EPEL
RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# X11 stuff
RUN yum install xorg-x11-drv-dummy x11-xserver-utils xterm tint2 fluxbox 

# Slicer dependencies
RUN yum install pulseaudio-libs-glib2 libXcomposite libXcursor libXrandr mesa-libEGL libGLU

# devel headers
RUN yum install -y zlib-devel \
                xorg-x11-proto-devel \
                xorg-x11-server-devel \
                python-argparse # mesa needs system python


# conda path
#RUN conda install gcc_linux-64 gxx_linux-64 llvmdev 
# conda activate...

#ENV PKG_CONFIG_PATH "$CONDA_PREFIX/lib/pkgconfig"

#RUN wget http://ftp.x.org/pub/individual/lib/libpciaccess-0.13.4.tar.bz2
#    ./configure --prefix=$CONDA_PREFIX --includedir=$CONDA_PREFIX/include
#    make install
#
#RUN wget https://dri.freedesktop.org/libdrm/libdrm-2.4.94.tar.bz2
#    ./configure --prefix=$CONDA_PREFIX PCIACCESS_LIBS="-L$CONDA_PREFIX/lib" LDFLAGS="-L$CONDA_PREFIX/lib -lpciaccess"

# mesa uses system python...

# mesa build
#   linking against the local /usr dirs is not great, but only option for GLX unless recompiling X11 locally
# ./configure --enable-glx=gallium-xlib --with-gallium-drivers=swrast,swr --disable-dri --disable-gbm --disable-egl --enable-gallium-osmesa --prefix=$CONDA_PREFIX --disable-llvm-shared-libs CFLAGS="-I/usr/include -L/usr/lib64"
