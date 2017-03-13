#!/bin/bash
sudo /usr/sbin/sshd -D &
echo cmd is $1
$1
