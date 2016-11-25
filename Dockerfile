FROM python:2.7
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN apt-get update
RUN apt-get install -y mysql-client
RUN apt-get install -y vim
RUN wget http://nodejs.org/dist/v0.10.38/node-v0.10.38.tar.gz
RUN tar zxvf node-v0.10.38.tar.gz
RUN cd  node-v0.10.38;./configure;make;make install;cd ..
RUN npm install pomelo -g
RUN git clone https://github.com/NetEase/lordofpomelo.git
#update generic-pool,SyntaxError: Use of const in strict mode
ADD game-server.json /usr/src/app/lordofpomelo/game-server/package.json
ADD web-server.json /usr/src/app/lordofpomelo/web-server/package.json
#Reduce service
ADD servers.json /usr/src/app/lordofpomelo/game-server/config/servers.json
#update mysql host and user
ADD mysql.json /usr/src/app/lordofpomelo/shared/config/mysql.json
RUN cd lordofpomelo;sh npm-install.sh
RUN apt-get install -y sysstat
RUN apt-get install -y w3m
RUN apt-get install -y net-tools
ADD README.md /usr/src/app/README.md
expose  3001
expose  3005
expose  3010
expose  3014
expose  3150
expose  3250
expose  3260
expose  3450
expose  3550
expose  3650
expose  3750
