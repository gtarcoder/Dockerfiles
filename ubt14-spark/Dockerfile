############################################
# version : debugman007/ubt14-hadoop-hbase:v1
# desc : ubuntu上安装的ssh，java, hadoop 
############################################
FROM debugman007/ubt14-ssh:v1

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

#安装和配置java环境
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
RUN sudo mkdir /opt/hadoop && sudo chown -R grad:grad /opt/hadoop

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV PATH ${HADOOP_HOME}/bin:$PATH


#安装spark
ADD spark-2.1.0-bin-hadoop2.7.tgz /usr/local/
RUN chown -R grad:grad /usr/local/spark-2.1.0-bin-hadoop2.7
RUN cd /usr/local/ && ln -s ./spark-2.1.0-bin-hadoop2.7 spark
RUN mkdir /opt/spark && chown -R grad:grad /opt/spark
ENV SPARK_HOME /usr/local/spark
ENV PATH ${SPARK_HOME}/bin:$PATH

COPY spark-env.sh /usr/local/spark/conf/

#安装scala
COPY scala-2.11.8.tgz /usr/local
RUN cd /usr/local && tar -zxvf scala-2.11.8.tgz && rm -rf scala-2.11.8.tgz && mv scala-2.11.8 scala
RUN chown -R grad:grad /usr/local/scala
ENV SCALA_HOME /usr/local/scala
ENV PATH ${SCALA_HOME}/bin:$PATH

USER grad
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

COPY bootstrap.sh /home/grad/  
RUN chmod 766 /home/grad/bootstrap.sh  

ENTRYPOINT ["/home/grad/bootstrap.sh"]  
CMD ["/bin/bash"]
