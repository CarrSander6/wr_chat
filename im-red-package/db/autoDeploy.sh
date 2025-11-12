#!/bin/sh
echo "==================================================="
echo "red-package..."
docker stop red-package
sleep 1
docker rm red-package
sleep 1
docker rmi red-package
sleep 1
cd /mnt/deploy/red-package
docker build  -t  red-package .
sleep 1
docker run -d --restart=always -h red-package --name red-package --net=host -e SPRING_PROFILES_ACTIVE=prod -v /mnt/deploy/red-package/logs:/app/logs -v /usr/share/fonts/:/usr/share/fonts/  red-package:latest
sleep 1
echo "auto deploy red-package success!"
