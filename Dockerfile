# centos 7
FROM centos:7
# 添加配置文件
ADD conf/client.conf /etc/fdfs/
ADD conf/http.conf /etc/fdfs/
ADD conf/mime.types /etc/fdfs/
ADD conf/storage.conf /etc/fdfs/
ADD conf/tracker.conf /etc/fdfs/
ADD fastdfs.sh /home
ADD conf/nginx.conf /etc/fdfs/
ADD conf/mod_fastdfs.conf /etc/fdfs

# run
RUN yum install git gcc gcc-c++ make automake autoconf libtool pcre pcre-devel zlib zlib-devel openssl-devel gd-devel wget vim -y \
  &&    cd /usr/local/src  \
  &&    git clone git://github.com/happyfish100/libfastcommon.git --depth 1        \
  &&    git clone git://github.com/happyfish100/fastdfs.git --depth 1    \
  &&    git clone git://github.com/happyfish100/fastdfs-nginx-module.git --depth 1   \
  &&    wget http://nginx.org/download/nginx-1.15.4.tar.gz    \
  &&    tar -zxvf nginx-1.15.4.tar.gz    \
  &&    mkdir /home/dfs   \
  &&    cd /usr/local/src/  \
  &&    cd libfastcommon/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd fastdfs/   \
  &&    ./make.sh && ./make.sh install  \
  &&    cd ../  \
  &&    cd nginx-1.15.4/  \
  &&    ./configure --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
  &&    make && make install  \
  &&    ./configure --prefix=/usr/local/nginx --with-http_image_filter_module --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
  &&    make && make install  \
  &&    chmod +x /home/fastdfs.sh

RUN ln -s /usr/local/src/fastdfs/init.d/fdfs_trackerd /etc/init.d/fdfs_trackerd \
  && ln -s /usr/local/src/fastdfs/init.d/fdfs_storaged /etc/init.d/fdfs_storaged 

# export config
VOLUME /etc/fdfs

EXPOSE 22122 23000 8888 80
ENTRYPOINT ["/home/fastdfs.sh"]
