docker run --name lordofpomelomysql -e MYSQL_ROOT_PASSWORD=12345 -d mysql:latest
docker build -t xcyxiner/lordofpomelo .
docker run --rm --link lordofpomelomysql:mysql -p 3001:3001 -p 3005:3005 -p 3010:3010 -p 3014:3014 -p 3150:3150 -p 3250:3250 -p 3260:3260 -p 3450:3450 -p 3550:3550 -p 3650:3650 -p 3750:3750 -t -i xcyxiner/lordofpomelo /bin/bash
