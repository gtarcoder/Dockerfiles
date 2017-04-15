#!/bin/bash
sudo /usr/sbin/sshd -D &
sudo service redis-server start
echo cmd is $1
$1
