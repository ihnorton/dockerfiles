FROM debian:sid-slim

# prevent apt-get from prompting for keyboard choice
#  https://superuser.com/questions/1356914/how-to-install-xserver-xorg-in-unattended-mode
ENV DEBIAN_FRONTEND=noninteractive

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

#&checksum=79051cdbb5928dde20dc13b7079aaf1d 

COPY xorg.conf /slicer
COPY run.sh /slicer

# don't run as root because chrome (webengine) sandbox doesn't support
RUN adduser --disabled-password --gecos "" sliceruser

ENTRYPOINT /slicer/run.sh
