#!/bin/bash
echo updating jenkins group for docker socket
group=$(stat -c %g /var/run/docker.sock)
sed -r 's/- (.*) #docker group id/- '"$group"' #docker group id/g' docker-compose.yml -i

echo setting system properties for sonarqube
sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

echo compose things
docker-compose up -d

