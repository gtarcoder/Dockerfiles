############################################
# version : debugman007/ubt14-hadoop-hbase-zk-thrift:v1
# desc : ubuntu上安装的ssh，java, hadoop 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

CMD sudo apt-get clean
CMD sudo apt-get update
CMD sudo apt-get install  gcc tcpdump lsof libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev make -y


#安装和配置java环境
#RUN yum -y install java-1.7.0-openjdk*
ADD jdk-7u80-linux-x64.tar.gz /usr/local/  

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin

#设置用户
RUN groupadd grad
RUN useradd -m grad -g grad
RUN echo "grad:grad" | chpasswd
RUN echo "grad ALL= NOPASSWD: ALL" >> /etc/sudoers

ADD hadoop-2.7.3.tar.gz  /usr/local/
RUN chown -R grad:grad /usr/local/hadoop-2.7.3
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
ADD hbase-1.2.4-bin.tar.gz /usr/local/
RUN chown -R grad:grad /usr/local/hbase-1.2.4
RUN cd /usr/local && ln -s ./hbase-1.2.4 hbase

ENV HBASE_HOME /usr/local/hbase
ENV PATH ${HBASE_HOME}/bin:$PATH

# 设置hadoop 和 hbase 的配置文件
ADD hadoop-env.sh $HADOOP_HOME/etc/hadoop/  
ADD mapred-env.sh $HADOOP_HOME/etc/hadoop/  
ADD yarn-env.sh $HADOOP_HOME/etc/hadoop/  
ADD core-site.xml $HADOOP_HOME/etc/hadoop/  
ADD hdfs-site.xml $HADOOP_HOME/etc/hadoop/  
ADD mapred-site.xml $HADOOP_HOME/etc/hadoop/  
ADD yarn-site.xml $HADOOP_HOME/etc/hadoop/  
ADD slaves $HADOOP_HOME/etc/hadoop/  

ADD hbase-env.sh $HBASE_HOME/conf/
ADD hbase-site.xml $HBASE_HOME/conf/
ADD regionservers $HBASE_HOME/conf/


#安装thrift，用于客户端使用c++等语言连接和操作 hbase
ADD thrift-0.10.0.tar.gz  /usr/local/ 
CMD cd /usr/local/thrift-0.10.0/ &&  ./configure && make && make install


#安装 zookeeper
# 安装配置 zookeeper
ADD zookeeper-3.4.9.tar.gz /usr/local/
RUN chown -R grad:grad /usr/local/zookeeper-3.4.9
RUN cd /usr/local/ && ln -s ./zookeeper-3.4.9 zookeeper

ENV ZOOKEEPER_HOME /usr/local/zookeeper
ENV PATH ${ZOOKEEPER_HOME}/bin:$PATH


#配置ssh
USER grad
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

#配置 hadoop hbase等目录
RUN sudo chown -R grad:grad $HADOOP_HOME/etc/hadoop
RUN sudo chown -R grad:grad $HBASE_HOME/conf
RUN sudo mkdir /opt/hadoop/ && sudo chown -R grad:grad /opt/hadoop 
RUN sudo chown -R grad:grad /home/grad
 
COPY bootstrap.sh /home/grad/  
RUN chmod 766 /home/grad/bootstrap.sh  

ENTRYPOINT ["/home/grad/bootstrap.sh"]  
