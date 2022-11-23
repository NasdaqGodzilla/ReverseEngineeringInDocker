FROM consol/ubuntu-xfce-vnc:latest

LABEL maintainer Niko "aug3073911@outlook.com"

ENV REFRESHED_AT 2022-11-24

ENV VNC_RESOLUTION 1920x1080
ENV VNC_PW ppllmmoo

ENV HOME=/headless

WORKDIR $HOME

# Set wallpaper
RUN rm -rf $HOME/.config/bg_sakuli.png
ADD wallpaper.png $HOME/.config/bg_sakuli.png

# Switch to root user to install pakcages
USER 0

RUN set -x; \
        apt update \
        && apt -y upgrade

RUN apt install -y software-properties-common sudo git

# JDK8
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update \
        && apt install -y openjdk-8-jdk

# Back to normal
USER 1000

# Jadx
WORKDIR $HOME
RUN mkdir project
WORKDIR $HOME/project
RUN git clone https://github.com/skylot/jadx.git jadx \
        && cd jadx \
        && ./gradlew dist \
        && ln -s $HOME/project/jadx/jadx-gui/build/install/jadx-gui/bin/jadx-gui $HOME/jadx-gui

# clean
USER 0
RUN apt autoremove --purge -y && apt clean && apt autoclean && rm -rf /var/lib/apt/lists/*
USER 1000

USER 1000
WORKDIR $HOME

