############################################
# version : debugman007/ubt14-zookeeper:v1
# desc : ubuntu上安装的ssh，java, zookeeper 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

CMD sudo apt-get clean
CMD sudo apt-get update


#安装和配置java环境
#RUN yum -y install java-1.7.0-openjdk*
ADD http://mirrors.linuxeye.com/jdk/jdk-7u80-linux-x64.tar.gz /usr/local/  
RUN cd /usr/local && tar -zxvf jdk-7u80-linux-x64.tar.gz && rm -f jdk-7u80-linux-x64.tar.gz

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#设置用户
RUN groupadd grad
RUN useradd -m grad -g grad
RUN echo "grad:grad" | chpasswd
RUN echo "grad ALL= NOPASSWD: ALL" >> /etc/sudoers

# 安装配置 zookeeper
ADD http://www-eu.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf zookeeper-3.4.9.tar.gz && rm -rf zookeeper-3.4.9.tar.gz 
RUN cd /usr/local/ && ln -s ./zookeeper-3.4.9 zookeeper && mkdir -p /usr/local/zookeeper/data
COPY zoo.cfg /usr/local/zookeeper/conf/
RUN chown -R grad:grad /usr/local/zookeeper-3.4.9

ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV PATH ${ZOOKEEPER_HOME}/bin:$PATH

#配置ssh
USER grad
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

COPY bootstrap.sh /home/grad/  
RUN chmod 766 /home/grad/bootstrap.sh  

ENTRYPOINT ["/home/grad/bootstrap.sh"] 
