# Breakwall  

## Trojan go 与 v2ray vmess+ws+tls 共存

```
Fork原项目后 Trojan 切换为 Tojan-go 
仅供测试。仅centos。其它平台自行查询相关命令即可。
这个项目是用于快速地使用Docker搭建breakwall服务
```

## 原理

### 443端口复用方法

```
因为Trojan会识别自己的流量，不是自己的可以转发其他Web服务器上面去
利用这一点可以做成Trojan->Caddy->V2ray
这样相当于复用了443端口
```

### 证书

```
证书由Caddy获取，然后将证书的目录映射到宿主机给Trojan使用
```

## 安装Docker

### 一键安装脚本

```
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
```

### CentOS

```
# 获取官方源
wget -P /etc/yum.repos.d/ https://download.docker.com/linux/centos/docker-ce.repo

# 安装docker ce
yum install -y docker-ce

# 启动、开机启动
systemctl start docker
systemctl enable docker
```

当然如果你想指定版本安装docker也是可以的

```
# 用下面的命令可以查看可以安装的版本
yum list docker-ce --showduplicates | sort -r
# 安装指定版本的Docker
yum install -y docker-ce-18.03.0.ce-1.el7.centos
```


## 安装Docker Compose（容器编排工具）
```
sudo curl -L https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

## 安装Git用于克隆代码

```
Centos:
yum install git
```

## 安装并使用TCP BBR 拥塞控制算法（可选）

教程参考：https://zhuanlan.zhihu.com/p/73565142

```
推荐BBRplus
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```

## 下载源码

```
git clone https://github.com/DLGum/V2ray_Trojan_Docker
```
```
如果是从原项目切换过来先运行
rm -rf /root/V2ray_Trojan_Docker
再git源码
```

## Setting

### 一键脚本设置

只需输入域名即可（eg: hello.com）

```
cd /root/V2ray_Trojan_Docker && ./OneKeySet.sh
Please input your server domain name(eg: abc.com): hello.com
Your domain name is: hello.com
-----------------------------------------------
V2ray Configuration:
Server: hello.com
Port: 443
UUID: c084ca0d-1c12-4be3-9226-74b817be6a2f
AlterId: 64
WebSocket Host: hello.com
WebSocket Path: /ray
TLS: True
TLS Host: hello.com
-----------------------------------------------
Trojan Configuration:
Server: hello.com
Port: 443
Password: 74b817be6a2f
-----------------------------------------------
Please run 'docker-compose up -d' to build!
Enjoy it!
```
同时会保存信息到info.txt中方便查阅


### 手动设置

```
0、centos安装vim

yum -y install vim*

1、在./caddy/Caddyfile中修改Caddy修改域名等

cd /root/V2ray_Trojan_Docker/caddy && vim Caddyfile

2、在./v2ray/config.json中修改V2Ray的UUID等配置

cd /root/V2ray_Trojan_Docker/v2ray && vim config.json

3、在./trojan/config/config.json中修改Trojan的密码等配置

cd /root/V2ray_Trojan_Docker/trojan-go/config && vim config.json
```


## 构建
```
docker-compose up -d
```

## 核心程序更新
```
停止容器
docker stop breakwall_trojan-go breakwall_v2ray
移除容器
docker rm breakwall_trojan-go breakwall_v2ray
查看容器状况
docker ps -a
重新构建
docker-compose up -d
重启docker
systemctl restart docker
```
## 网站配置

```
应网友需求，如果需要部署静态网站替换掉Caddy的默认页，只需要将网站放入caddy/www里面即可
```

**Enjoy it!**
