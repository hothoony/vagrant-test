FROM centos:8

# yum repo mirrorlist 수정
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

# RUN yum update -y
# # ifconfig
# RUN yum install -y net-tools
# # nslookup
# RUN yum install -y bind-utils
# RUN yum install -y wget
# RUN yum install -y vim
# RUN yum install -y sudo
# # service
# RUN yum install -y initscripts

RUN mkdir this_linux_was_created_by_VAGRANT_UP

## run OK
ENTRYPOINT ["tail", "-f", "/dev/null"]

## run OK
# ENTRYPOINT ["tail"]
# CMD ["-f", "/dev/null"]
