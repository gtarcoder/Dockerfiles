############################################
# version : debugman007/ubt14-kafka:v2
# desc : ubuntu上安装的ssh，java, kafka 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

RUN sudo apt-get update
RUN sudo apt-get install vim wget -y

#安装和配置java环境
#RUN yum -y install java-1.7.0-openjdk*
ADD jdk-7u80-linux-x64.tar.gz /usr/local/  

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#安装和配置 kafka
COPY kafka_2.11-0.10.2.0.tgz /usr/local/
RUN cd /usr/local && tar -zxvf kafka_2.11-0.10.2.0.tgz && rm -rf kafka_2.11-0.10.2.0.tgz && mv kafka_2.11-0.10.2.0 kafka

ENV KAFKA_HOME /usr/local/kafka
ENV PATH $PATH:/usr/local/kafka/bin

RUN groupadd grad
RUN useradd -m grad -g grad
RUN echo "grad:grad" | chpasswd

RUN chown -R grad:grad /usr/local/kafka 


RUN echo "grad ALL= NOPASSWD: ALL" >> /etc/sudoers

USER grad
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

##配置 bootstrap
COPY bootstrap.sh /home/grad/  
RUN chmod 766 /home/grad/bootstrap.sh  
  
ENTRYPOINT ["/home/grad/bootstrap.sh"]  
CMD ["/bin/bash"]
