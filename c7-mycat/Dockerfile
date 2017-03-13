############################################
# version : debugman007/c7-mycat:v1
# desc : centos7 上安装的mycat
############################################
# 设置继承自 centos7 官方镜像
FROM centos:7 

RUN echo "root:root" | chpasswd

RUN yum -y install net-tools

# install java
ADD http://mirrors.linuxeye.com/jdk/jdk-7u80-linux-x64.tar.gz /usr/local/  
RUN cd /usr/local && tar -zxvf jdk-7u80-linux-x64.tar.gz && rm -f jdk-7u80-linux-x64.tar.gz

ENV JAVA_HOME /usr/local/jdk1.7.0_80
ENV CLASSPATH ${JAVA_HOME}/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:${JAVA_HOME}/bin


#install mycat
ADD http://dl.mycat.io/1.6-RELEASE/Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz /usr/local
RUN cd /usr/local && tar -zxvf Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz && rm -f Mycat-server-1.6-RELEASE-20161028204710-linux.tar.gz  

VOLUME /usr/local/mycat/conf
EXPOSE 8066 9066
CMD ["/usr/local/mycat/bin/mycat", "console"]
