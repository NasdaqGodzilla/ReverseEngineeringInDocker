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

# Homebrew
WORKDIR $HOME
USER 0
RUN add-apt-repository -y ppa:git-core/ppa \
        && apt update \
        && apt install -y --no-install-recommends \
                bzip2 \
                ca-certificates \
                curl \
                file \
                fonts-dejavu-core \
                g++ \
                locales \
                make \
                openssh-client \
                patch \
                uuid-runtime
RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
        && useradd -m -s /bin/bash linuxbrew \
        && echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
USER 1000
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Python pyenv pip3 setuptools
USER 1000
WORKDIR $HOME
RUN brew install python@3.9 pyenv
RUN python3.9 -m pip install --upgrade pip
RUN python3.9 -m pip install --upgrade setuptools

# clean
USER 0
RUN apt autoremove --purge -y && apt clean && apt autoclean && rm -rf /var/lib/apt/lists/*
USER 1000

RUN set +x
WORKDIR $HOME

