#!/bin/bash
sudo /usr/sbin/sshd -D &
echo 'myid is ' $1
echo $1 > /usr/local/zookeeper/data/myid
cd /usr/local/zookeeper/data && zkServer.sh start
/bin/bash
