# lordofpomelo
lordofpomelo docker environment
#按照习惯，先弄运行环境，再调研，没想到又一次被坑了，倒霉的运气，留点纪念
---20161125 xcyxiner

#不看后文直接运行版(docker 环境不会，这个自己想办法)
```
需要执行的命令如下，下载官方mysql库，并设置root密码
docker run --name lordofpomelomysql -e MYSQL_ROOT_PASSWORD=12345 -d mysql:latest


运行编译好的镜像
docker run --rm --link lordofpomelomysql:mysql -p 3001:3001 -p 3005:3005 -p 3010:3010 -p 3014:3014 -p 3150:3150 -p 3250:3250 -p 3260:3260 -p 3450:3450 -p 3550:3550 -p 3650:3650 -p 3750:3750 -t -i xcyxiner/lordofpomelo /bin/bash


运行上条命令后，执行如下命令,按照里面的命令，该初始化数据库该还是直接运行，这个看自己

cat README.md  


PS：为啥这么复杂？mysql我不知道怎么初始化官方给的sql文件。。。。。

PS: README.md内容如下(至于密码为啥不写，因为写了貌似不管用，得还是自己输入.mysql 退出希望你懂，不懂，我觉得你可以忽略了。。。)
#首页先初始化数据库
mysql -h mysql -u root -p (登录成功提示符：mysql>)
mysql> create database Pomelo;
mysql> use Pomelo;
mysql> source /usr/src/app/lordofpomelo/game-server/config/schema/Pomelo.sql

#如果已初始过数据，请按如下命令运行
cd /usr/src/app/lordofpomelo/game-server/
pomelo start --daemon
cd /usr/src/app/lordofpomelo/web-server/
node app.js &


PS: 怎么运行？  浏览器打开 http://xxx.xxx.xxx.xxx:3001  (docker 宿主机IP 你应该会查,不是172.xxx.xxx.xxx，应该是你们局域网那个IP（192.xxx.xxx.xx))

```




#以下是遇到的一些坑以及参考资料

#官方安装指南
[LordOfPomelo 安装指南](https://github.com/NetEase/pomelo/wiki/LordOfPomelo-%E5%AE%89%E8%A3%85%E6%8C%87%E5%8D%97)
#关于node7
node7 别试了，pomelo都初始化失败，
#关于node6，node4
npm-install.sh 会让 node gyp坑到怀疑人生，看到有别人安装成功的，但是没试成功。。

别人家成功的看这个
[webStorm 远程调试Node 及 lordofpomelo 配置](http://www.tishoy.com/?p=185)

#sh安装正常一点的(node v0.10.*) 

[阿里云上架设LordofPomelo全流程](http://www.fx114.net/qa-233-158324.aspx)

[lordofpomelo --> game_server --> pomelo start 启动失败](http://nodejs.netease.com/topic/577cb59db9b9789366843e2a)

## pomelo start 启动失败 SyntaxError: Use of const in strict mode 报错的方案

如果你使用了上面的v0.10.26之类，

我这边启动就爆了上面的错，你没看错。。

这货是generic-pool报错的，原因点下面这个看 


[SyntaxError: Use of const in strict mode](http://stackoverflow.com/questions/22603078/syntaxerror-use-of-const-in-strict-mode)



至于怎么解决，game-server/package.json 

以及 web-server/package.json中 

```
原来的

"generic-pool": ">=1.0.9"

换成如下,我没耐心去找更高的版本，就只用最低的版本了==

更换之后的

"generic-pool": "1.0.9"

```

注意 记得装 apt-get install sysstat,因为里面监控的可能用了 pidstat之类的
==========

#只保留一个,剩下所开的端口

```
3001  -web
3005  -master server
3010  -client
3014  -gate
3150  -connector
3250  -area
3260  -area(instance)
3450  -chat
3550  -path
3650  -auth
3750  -manager
```







