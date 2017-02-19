############################################
# version : debugman007/ubt14-hadoop-hbase:master
# desc : ubuntu上安装的ssh，java, hadoop, hbase
############################################
FROM debugman007/ubt14-hadoop-hbase:base

# 下面是一些创建者的基本信息
MAINTAINER debugman007 (skc361@163.com)

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

USER hadoop
RUN sudo mkdir -p /opt/hadoop/data/zookeeper
RUN sudo chown -R hadoop:hadoop $HADOOP_HOME/etc/hadoop  
RUN sudo chown -R hadoop:hadoop $HBASE_HOME/conf
RUN sudo chown -R hadoop:hadoop /opt/hadoop  
RUN sudo chown -R hadoop:hadoop /home/hadoop  
  
COPY bootstrap.sh /home/hadoop/  
RUN chmod 766 /home/hadoop/bootstrap.sh  
  
ENTRYPOINT ["/home/hadoop/bootstrap.sh"]  
CMD ["/bin/bash"]
