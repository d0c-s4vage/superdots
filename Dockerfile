FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        vim \
        git \
        wget \
        curl \
        tmux \
        python-pip \
        python3-pip \
        powerline \
        fonts-powerline \
        python-powerline \
        libncurses-dev \
        readline-common \
        libreadline7 \
        python \
        build-essential \
        tmux \
        screen \
        ssh \
        gimp \
        openvpn \
    && pip install peewee arrow virtualenv \
    && pip3 install peewee arrow virtualenv \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN useradd \
    -m \
    -d /home/user \
    -s /bin/bash \
    user

#RUN git clone https://github.com/d0c-s4vage/dot-your-mom ~/.your-mom \
COPY dot-your-mom /home/user/.your-mom
RUN chown -R user:user /home/user/.your-mom/

USER user
ENV TERM=xterm-256color
WORKDIR /home/user

RUN /home/user/.your-mom/install.sh

ENTRYPOINT ["bash", "-il"]
