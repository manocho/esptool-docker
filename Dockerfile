# ESPTOOL for Docker using Python 3.9.18
# Version 1.0

FROM python:latest
LABEL maintainer="manocho@gmail.com"
ARG VERSION=4.7
ARG USERNAME=esptool
ARG USERPASS=password

# APT Setup
RUN apt-get update
RUN apt-get install -y screen git mc openssh-server sudo
RUN rm -rf /var/lib/apt/lists/*

# USER Setup
RUN useradd -ms /bin/bash $USERNAME
RUN echo "$USERNAME:$USERPASS" | chpasswd
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN usermod -aG dialout $USERNAME

# SSH Setup
COPY entrypoint.sh entrypoint.sh
RUN chmod +x /entrypoint.sh

USER $USERNAME
RUN mkdir /home/$USERNAME/.ssh && touch /home/$USERNAME/.ssh/authorized_keys
WORKDIR /work

USER root
VOLUME /home/$USERNAME/.ssh
VOLUME /etc/ssh
VOLUME /work

# ESPTOOL Setup
RUN echo "esptool version:" $VERSION && \
    pip3 install esptool==${VERSION}
WORKDIR /work

CMD ["/entrypoint.sh"]


# Test de Entrypoint:
#ENTRYPOINT ["/usr/local/bin/esptool.py"]
#CMD ["--help"]

# Build con:
# docker build -t esptool-docker:1.0 .

# Ejecutar con:
# docker run -it --device=/dev/ttyUSB0 --name esptool esptool-docker:1.0
# docker run -d -p 2222:22 --device=/dev/ttyUSB0 --name esptool esptool-docker:1.0