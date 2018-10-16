FROM debian:sid-20181011-slim

# prevent apt-get from prompting for keyboard choice
#  https://superuser.com/questions/1356914/how-to-install-xserver-xorg-in-unattended-mode
ENV DEBIAN_FRONTEND=noninteractive
COPY cleaner_dpkg.txt /etc/dpkg/dpkg.cfg.d/01_nodoc


################################################################################
# - update apt, set up certs, run netselect to get fast mirror
# - reduce apt gravity
# - and disable caching
#   from https://blog.sleeplessbeastie.eu/2017/10/02/how-to-disable-the-apt-cache/
RUN echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' >> /etc/apt/apt.conf && \
    echo 'Dir::Cache::pkgcache "";\nDir::Cache::srcpkgcache "";' | tee /etc/apt/apt.conf.d/00_disable-cache-files

RUN apt-get update -q -y

################################################################################
# get packages
# - update
# - install things
#   - basic  tools
#   - slicer dependencies
#   - awesome window manager
RUN apt-get install -q -y \
 vim net-tools curl \
 libgl1-mesa-glx \
 xserver-xorg-video-dummy \
 libxrender1 \
 libpulse0 \
 libpulse-mainloop-glib0  \
 libnss3  \
 libxcomposite1 \
 libxcursor1 \
 libfontconfig1 \
 libxrandr2 \
 libasound2 \
 libglu1 \
 x11vnc \
 awesome \
 python3 python3-pip python3-setuptools

################################################################################
# install jupyter
RUN pip3 install jupyter


################################################################################
# set up user
ENV NB_USER sliceruser
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
            --gecos "Default user" \
            --uid ${NB_UID} \
            ${NB_USER}

WORKDIR ${HOME}


################################################################################
# get slicer
# Download and unpack Slicer
#RUN curl -O -J -L "http://slicer.kitware.com/midas3/api/rest?method=midas.bitstream.download&name=Slicer-4.9.0-2018-10-14-linux-amd64.tar.gz&checksum=da328e50014d5562af1659d77a207567" && \
ADD --chown=sliceruser Slicer-4.9.0-2018-10-14-linux-amd64.tar.gz ${HOME}
COPY --chown=sliceruser 634b0ef-linux-amd64-SlicerJupyter-git4772650-2018-10-03.tar.gz .

################################################################################
# these go after installs to avoid trivial invalidation
ENV VNCPORT=49053
ENV JUPYTERPORT=8888
ENV DISPLAY=:10

COPY xorg.conf .
COPY run.sh .
COPY install.sh .


################################################################################
# mybinder requirement
RUN chown ${NB_USER} ${HOME}


################################################################################
# need to run Slicer as non-root because
# - mybinder requirement
# - chrome sandbox inside QtWebEngine does not support root.
USER ${NB_USER}


################################################################################
# Set up SlicerJupyter
# TODO: use buildbot version
# for now build with ihnorton/dockerfiles/slicerjupyter-linux
# and host pending
#   https://github.com/Slicer/SlicerJupyter/issues/5

RUN ./install.sh


################################################################################
EXPOSE $VNCPORT $JUPYTERPORT
ENTRYPOINT ${HOME}/run.sh
CMD []
