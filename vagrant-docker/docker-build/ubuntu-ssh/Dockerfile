FROM ubuntu:20.04

RUN apt update -y
RUN apt install -y net-tools
RUN apt install -y dnsutils
RUN apt install -y iputils-ping
RUN apt install -y curl wget vim
RUN apt install -y systemd
RUN apt install -y sudo

# ssh server install
RUN apt install -y openssh-server
RUN sed -i'' -r 's/^#PermitRootLogin (\w|-)+/PermitRootLogin yes/g' /etc/ssh/sshd_config
# RUN sed -i'' -r 's/^#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# RUN sed -i'' -r 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config

# change root password
RUN echo root:root | chpasswd

# create user vagrant
RUN adduser vagrant
RUN echo vagrant:vagrant | chpasswd

# add sudoers user vagrant
# vi /etc/sudoers
# vagrant ALL=(ALL:ALL) ALL

RUN mkdir this_linux_was_created_by_VAGRANT_UP

# ssh server start
RUN service ssh start
EXPOSE 22/tcp
CMD ["/usr/sbin/sshd", "-D"]

## run OK
# ENTRYPOINT ["tail", "-f", "/dev/null"]

## run OK
# ENTRYPOINT ["tail"]
# CMD ["-f", "/dev/null"]
