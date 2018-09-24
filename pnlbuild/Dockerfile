FROM centos:6.10

WORKDIR /opt

RUN yum install -y wget curl ca-certificates

RUN yum install -y flex fontconfig freetype glib2 libICE libX11 libxcb libXext libXi libXrender libSM libXt-devel libGLU-devel mesa-libOSMesa-devel mesa-libGL-devel mesa-libGLU-devel xcb-util-keysyms xcb-util-image

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p `pwd`/conda3

ENV PATH /opt/conda3/bin:$PATH

ADD environment.yml ./

RUN conda env create -f environment.yml

ENV PATH /opt/conda3/envs/pnlbuild/bin:$PATH

ADD build.sh ./

# Note: some ANTs templated files blow up the compiler, use lower
# `-j` number to avoid weird interrupted errors from as and g++
RUN ./build.sh
