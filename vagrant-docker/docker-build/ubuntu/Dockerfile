FROM ubuntu:20.04

RUN apt update -y
RUN apt install -y net-tools
RUN apt install -y dnsutils
RUN apt install -y iputils-ping
RUN apt install -y curl wget vim
RUN apt install -y systemd

# install ssh server
RUN apt install -y openssh-server
RUN sed -i'' -r 's/^#PermitRootLogin (\w|-)+/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN service ssh start

# root password change
RUN echo root:1111 | chpasswd

RUN mkdir this_linux_was_created_by_vagrant_up

## run OK
ENTRYPOINT ["tail", "-f", "/dev/null"]

## run OK
# ENTRYPOINT ["tail"]
# CMD ["-f", "/dev/null"]

EXPOSE 22/tcp
