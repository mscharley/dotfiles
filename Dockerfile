FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes \
      zsh openssh-client sudo \
      gnupg2 pinentry-tty curl \
      git most vim && \
    rm -rf /var/lib/apt/lists/*

RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo-group && \
    chmod 0440 /etc/sudoers.d/sudo-group
RUN useradd -m -s /usr/bin/zsh -G sudo ubuntu

USER ubuntu
WORKDIR /home/ubuntu
COPY ./ /home/ubuntu/.dotfiles
RUN mkdir bin/ && \
    gpg-agent --daemon && \
    cd .dotfiles && yes | ./install.pl

CMD ["/usr/bin/zsh", "-l"]
