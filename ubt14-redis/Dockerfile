############################################
# version : debugman007/ubt14-redis:v1
# desc : ubuntu上安装的ssh，redis 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

#安装redis
RUN sudo apt-get update && sudo apt-get install -y redis-server

#设置用户
RUN groupadd grad
RUN useradd -m grad -g grad
RUN echo "grad:grad" | chpasswd
RUN echo "grad ALL= NOPASSWD: ALL" >> /etc/sudoers

EXPOSE  6379

USER grad
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

COPY bootstrap.sh /home/grad/  
RUN chmod 766 /home/grad/bootstrap.sh  

ENTRYPOINT ["/home/grad/bootstrap.sh"]  
CMD ["/bin/bash"]
