############################################
# version : debugman007/ssh:v1
# desc : ubuntu14.04 上安装的ssh
############################################
# 设置继承自ubuntu14.04官方镜像
FROM ubuntu:14.04 

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

RUN rm -vf /var/lib/apt/lists/*
RUN apt-get update 
RUN apt-get install -y openssh-server openssh-client vim wget curl sudo

#添加用户 test，设置密码为 test, 赋予sudo权限
RUN useradd  -m test 
RUN echo "test:test" | chpasswd
RUN cd /etc/sudoers.d && touch nopasswdsudo && echo "test ALL=(ALL) ALL" >> nopasswdsudo
#把test用户的shell改成bash，否则ssh登录ubuntu服务器，命令行不显示用户名和目录
RUN usermod -s /bin/bash test

RUN echo "root:root" | chpasswd

#配置ssh
RUN mkdir /var/run/sshd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

USER test
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

USER root
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
