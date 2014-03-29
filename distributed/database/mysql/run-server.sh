#!/bin/bash 

TAG="drupaltestbot-mysql"
NAME="drupaltestbot-db"
STALLED=$(docker ps -a | grep ${TAG} | grep Exit | awk '{print $1}')
RUNNING=$(docker ps | grep ${TAG} | grep 3306)
if [[ $RUNNING != "" ]]
  then 
    echo "Found database container:" 
    echo "$RUNNING already running..."
    exit 0
  elif [[ $STALLED != "" ]]
    then
    echo "Found old container $STALLED. Removing..."
    docker rm $STALLED
    umount /tmp/tmp.*;
fi
  
set -e 
TMPDIR=$(mktemp -d)
mount -t tmpfs -o size=16000M tmpfs $TMPDIR || exit

MYSQL_ID=$(docker run -d -p=3306 --name=${NAME} -v="$TMPDIR":/var/lib/mysql ${TAG})
CONTAINER_ID=$(docker ps | grep ${TAG} | awk '{print $1}')

#PORT=$(docker port $MYSQL_ID 3606 | cut -d":" -f2)
#TAG="drupaltestbot-mysql"

echo "CONTAINER STARTED: $CONTAINER_ID"

docker ps | grep drupaltestbot-mysql

