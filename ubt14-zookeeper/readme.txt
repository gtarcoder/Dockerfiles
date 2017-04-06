该镜像中使用了三个zookeeper节点来搭建zookeeper集群。
分别是 zookeeper1, zookeeper2, zookeeper3, 这三个节点(docker 容器)使用overlay网络(multihost)可以分布在多个物理机器上。

创建容器
docker create -it --name zookeeper1 --net multihost -h zookeeper1 debugman007/ubt14-zookeeper:v1 0 
docker create -it --name zookeeper2 --net multihost -h zookeeper2 debugman007/ubt14-zookeeper:v1 1
docker create -it --name zookeeper3 --net multihost -h zookeeper3 debugman007/ubt14-zookeeper:v1 2 
//上面的语句中最后一个参数0,1,2 分别表示该节点在zookeeper集群中的序号
