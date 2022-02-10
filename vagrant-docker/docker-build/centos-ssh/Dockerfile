FROM centos:8

# yum repo mirrorlist 수정
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

# RUN yum update -y
# # service
# RUN yum install -y initscripts
# RUN yum install -y epel-release
# # ifconfig
RUN yum install -y net-tools
# # nslookup
RUN yum install -y bind-utils
# RUN yum install -y wget
# RUN yum install -y vim
# RUN yum install -y sudo

# ssh server install
RUN yum install -y openssh-server
RUN sed -i'' -r 's/^#PermitRootLogin (\w|-)+/PermitRootLogin yes/g' /etc/ssh/sshd_config
# RUN sed -i'' -r 's/^#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
# RUN sed -i'' -r 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/g' /etc/ssh/sshd_config
RUN sed -i -r 's/^#Port 22/Port 22/g' /etc/ssh/sshd_config
# RUN systemctl start sshd

# change root password
RUN echo root:root | chpasswd

# create user vagrant
RUN adduser vagrant
RUN echo vagrant:vagrant | chpasswd
WORKDIR /home/vagrant
USER vagrant
RUN touch vagrant_user_test && exit
RUN echo "alias ll='ls -alF'" >> ~/.bashrc && source ~/.bashrc && exit

WORKDIR /
USER root
# add alias
RUN echo "alias ll='ls -alF'" >> ~/.bashrc && \
    source ~/.bashrc

RUN mkdir this_linux_was_created_by_VAGRANT_UP

## run OK
ENTRYPOINT ["/usr/sbin/init"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]

## run OK
# ENTRYPOINT ["tail"]
# CMD ["-f", "/dev/null"]
