FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        curl \
        fonts-powerline \
        gimp \
        git \
        htop \
        libncurses-dev \
        libreadline7 \
        openvpn \
        powerline \
        python \
        python3-pip \
        python-pip \
        python-powerline \
        readline-common \
        screen \
        ssh \
        tmux \
        tmux \
        tree \
        vim \
        wget \
    && pip install peewee arrow virtualenv \
    && pip3 install peewee arrow virtualenv \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN useradd \
    -m \
    -d /home/user \
    -s /bin/bash \
    user

#RUN git clone https://github.com/d0c-s4vage/superdots ~/.superdots \
COPY . /home/user/.superdots
RUN chown -R user:user /home/user/.superdots/

USER user
ENV TERM=xterm-256color
WORKDIR /home/user

# don't add to sudoers! it's intended that the host user's home directory will
# be mounted into this directory

RUN /home/user/.superdots/bin/install

ENTRYPOINT ["bash", "-il"]
