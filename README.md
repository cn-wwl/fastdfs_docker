# FastDFS Dockerfile network (网络版本)

## 声明
基于作者的[docker](https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network)安装方式 进行了一些修改：

- 修改`Dockerfile` 无法通过https访问github地址的问题
- 修改了`nginx.conf`，使其支持访问时生成缩略图(aa.jpg?w=50&h=50)




## 目录介绍
### conf 
Dockerfile 所需要的一些配置文件
当然你也可以对这些文件进行一些修改  比如 storage.conf 里面的 bast_path 等相关

## 使用方法
需要注意的是 你需要在运行容器的时候制定宿主机的ip 用参数 FASTDFS_IPADDR 来指定



```
docker run -itd --name 容器名 --network=host -e FASTDFS_IPADDR=192.168.0.140 --privileged=true -v /home/dfs:/home/dfs 镜像名
```

