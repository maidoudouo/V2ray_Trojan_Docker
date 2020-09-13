# Breakwall  

## Trojan go 与 v2ray vless + ws + tls 共存
```
dev版仅自己玩。
仅将vmess改为vless简单切换无其他任何变化。
vless专用的配置文件日后更新。
```
```
可以不git这里的源码。
直接搭建好原版后，运行
cd /root/V2ray_Trojan_Docker/v2ray && vim config.json
把vmess改为vless。
保存重启docker
systemctl restart docker
既可以完成切换至vless
```
