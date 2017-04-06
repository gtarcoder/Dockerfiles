#!/bin/bash
sudo /usr/sbin/sshd -D &
if [ $# -eq 1 ]
then
    echo 'myid is ' $1
    mkdir -p /usr/local/zookeeper/data/
    echo $1 > /usr/local/zookeeper/data/myid
    cd /usr/local/zookeeper/data && zkServer.sh start
fi
/bin/bash
