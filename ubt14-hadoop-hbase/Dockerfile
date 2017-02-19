############################################
# version : debugman007/ubt14-hadoop-hbase:v1
# desc : ubuntu上安装的ssh，java, hadoop 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

#为hadoop集群提供dns服务
RUN sudo apt-get -y install dnsmasq

#安装和配置java环境
#RUN yum -y install java-1.7.0-openjdk*
ADD http://mirrors.linuxeye.com/jdk/jdk-7u80-linux-x64.tar.gz /usr/local/  
RUN cd /usr/local && tar -zxvf jdk-7u80-linux-x64.tar.gz && rm -f jdk-7u80-linux-x64.tar.gz

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#安装和配置 hadoop
RUN groupadd hadoop
RUN useradd -m hadoop -g hadoop
RUN echo "hadoop:hadoop" | chpasswd

ADD http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz  /usr/local/
RUN cd /usr/local && tar -zxvf hadoop-2.7.3.tar.gz && rm -f  hadoop-2.7.3.tar.gz
RUN chown -R hadoop:hadoop /usr/local/hadoop-2.7.3
RUN cd /usr/local && ln -s ./hadoop-2.7.3 hadoop

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV PATH ${HADOOP_HOME}/bin:$PATH

ADD http://www-eu.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf hbase-1.2.4-bin.tar.gz && rm -f hbase-1.2.4-bin.tar.gz 
RUN chown -R hadoop:hadoop /usr/local/hbase-1.2.4
RUN cd /usr/local && ln -s ./hbase-1.2.4 hbase

ENV HBASE_HOME /usr/local/hbase
ENV PATH ${HBASE_HOME}/bin:$PATH


RUN echo "hadoop ALL= NOPASSWD: ALL" >> /etc/sudoers

USER hadoop
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
