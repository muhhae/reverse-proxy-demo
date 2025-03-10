FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server sudo neovim && mkdir /var/run/sshd

RUN useradd -m -s /bin/bash -G sudo vm && echo 'vm:123' | chpasswd

RUN echo 'root:root' | chpasswd

RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN echo '[[ "$TERM" == "xterm-kitty" ]] && export TERM="xterm-256color"' >> /home/vm/.bashrc

EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/sshd", "-D"]
