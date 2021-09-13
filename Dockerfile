FROM ubuntu:focal

RUN apt update && apt install -y x11vnc xvfb fluxbox wget wmctrl gnupg openfortivpn openresolv sudo

RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps && adduser --disabled-password apps sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt update && apt install -y google-chrome-stable 

COPY shell.sh /usr/local/bin/shell
RUN chmod +x /usr/local/bin/shell

COPY fortivpn.conf /etc/openfortivpn/config
COPY bootstrap.sh /

RUN chmod +x bootstrap.sh

CMD '/bootstrap.sh'