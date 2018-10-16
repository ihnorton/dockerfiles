FROM debian:sid-slim

# prevent apt-get from prompting for keyboard choice
#  https://superuser.com/questions/1356914/how-to-install-xserver-xorg-in-unattended-mode
ENV DEBIAN_FRONTEND=noninteractive

ENV VNCPORT=49053

WORKDIR /slicer

RUN apt-get update -qy \
    && apt-get install -qy vim net-tools curl wget


RUN curl -O -J -L "http://slicer.kitware.com/midas3/api/rest?method=midas.bitstream.download&name=Slicer-4.9.0-2018-10-14-linux-amd64.tar.gz&checksum=da328e50014d5562af1659d77a207567" && \
    tar xf Slicer-4.9.0-2018-10-14-linux-amd64.tar.gz && \
    rm Slicer-4.9.0-2018-10-14-linux-amd64.tar.gz

RUN apt-get update -qy \
    && apt-get install -qy vim               \
                    net-tools                \
                    wget                     \
    && apt-get -qy install awesome           \
    && apt-get -qy install libgl1-mesa-glx   \
                    xserver-xorg-video-dummy \
                    libxrender1              \
                    libpulse0                \
                    libpulse-mainloop-glib0  \
                    libnss3                  \
                    libxcomposite1           \
                    libxcursor1              \
                    libfontconfig1           \
                    libxrandr2               \
                    libasound2               \
                    libglu1                  \
                    x11vnc
######
# TODO move these to top
RUN apt-get install -q -y netselect netselect-apt && \
    netselect-apt testing
# from https://blog.sleeplessbeastie.eu/2017/10/02/how-to-disable-the-apt-cache/
RUN echo -e 'Dir::Cache::pkgcache "";\nDir::Cache::srcpkgcache "";' > sudo tee /etc/apt/apt.conf.d/00_disable-cache-files
######

# install jupyter
RUN apt-get install -y -q python3 python3-pip && \
    pip3 install jupyter

######
# TODO move these to top
ENV DISPLAY=:10
COPY cleaner_dpkg.txt /etc/dpkg/dpkg.cfg.d/01_nodoc
RUN echo 'APT::Install-Recommends "0" ; APT::Install-Suggests "0" ;' > /etc/apt/apt.conf
######

COPY xorg.conf /slicer
COPY run.sh /slicer
COPY install.sh /slicer

# Set up Jupyter
# TODO get from extension manager pending
#   https://github.com/Slicer/SlicerJupyter/issues/5
COPY 634b0ef-linux-amd64-SlicerJupyter-git4772650-2018-10-03.tar.gz .
RUN tar xf 634b0ef-linux-amd64-SlicerJupyter-git4772650-2018-10-03.tar.gz

####################################
# need to run Slicer as non-root because chrome sandbox (inside QtWebEngine)
# does not support root. And docker discourages using sudo.
RUN adduser --disabled-password --gecos "" sliceruser
RUN chmod ugo+rwx /slicer
WORKDIR /nb
RUN chmod ugo+rwx /nb

# need HOME, it is not auto-set by docker
ENV HOME=/home/sliceruser
USER sliceruser
## CONTAINER RUNNING AS sliceruser NOW

# SlicerJupyter and kernel install
RUN /slicer/install.sh

EXPOSE $VNCPORT
ENTRYPOINT /slicer/run.sh
