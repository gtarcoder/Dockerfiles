############################################
# version : debugman007/ubt14-hadoop-hbase-zk-thrift:v1
# desc : ubuntu上安装的ssh，java, hadoop 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

CMD sudo apt-get clean
CMD sudo apt-get update
CMD sudo apt-get install  -y tcpdump lsof libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev make


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

# 安装配置 hbase
ADD http://www-eu.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf hbase-1.2.4-bin.tar.gz && rm -f hbase-1.2.4-bin.tar.gz 
RUN chown -R hadoop:hadoop /usr/local/hbase-1.2.4
RUN cd /usr/local && ln -s ./hbase-1.2.4 hbase

ENV HBASE_HOME /usr/local/hbase
ENV PATH ${HBASE_HOME}/bin:$PATH

# 安装配置 zookeeper
ADD http://www-eu.apache.org/dist/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz /usr/local/
RUN cd /usr/local && tar -zxvf zookeeper-3.4.9.tar.gz && rm -rf zookeeper-3.4.9.tar.gz 
RUN chown -R hadoop:hadoop /usr/local/zookeeper-3.4.9
RUN cd /usr/local/ && ln -s ./zookeeper-3.4.9 zookeeper

ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV PATH ${ZOOKEEPER_HOME}/bin:$PATH

#安装thrift，用于客户端使用c++等语言连接和操作 hbase
ADD http://www-eu.apache.org/dist/thrift/0.10.0/thrift-0.10.0.tar.gz  /usr/local/ 
CMD cd /usr/local && tar -zxvf thrift-0.10.0.tar.gz && rm thrift-0.10.0.tar.gz 
CMD cd /usr/local/thrift-0.10.0/ &&  ./configure && make && make install

RUN echo "hadoop ALL= NOPASSWD: ALL" >> /etc/sudoers

#配置ssh
USER hadoop
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

#配置 hadoop hbase等目录
RUN sudo mkdir -p /opt/hadoop/data/zookeeper
RUN sudo chown -R hadoop:hadoop $HADOOP_HOME/etc/hadoop  
RUN sudo chown -R hadoop:hadoop $HBASE_HOME/conf
RUN sudo chown -R hadoop:hadoop /opt/hadoop  
RUN sudo chown -R hadoop:hadoop /home/hadoop  
 
COPY bootstrap.sh /home/hadoop/  
RUN chmod 766 /home/hadoop/bootstrap.sh  

ENTRYPOINT ["/home/hadoop/bootstrap.sh"]  
CMD ["/bin/bash"]
