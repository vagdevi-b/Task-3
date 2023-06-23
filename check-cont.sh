#!/bin/bash

CONTAINER_1=vagdevi-nginx-cont
CONTAINER_2=vagdevi-mysql-cont

STATUS_1=$(docker container inspect -f '{{.State.Status}}' $CONTAINER_1 2>/dev/null)
STATUS_2=$(docker container inspect -f '{{.State.Status}}' $CONTAINER_2 2>/dev/null)


# Check if the container is running

if [ "$STATUS_1" = "running" ] && [ "$STATUS_2" = "running" ]; then
    echo "Containers are up and running."
else
    echo "Containers are not up and running."
fi

# Check ping from Container 1 to Container 2

if docker exec $CONTAINER_1 ping -c 3 $CONTAINER_2 >/dev/null; then
  echo "Ping from $CONTAINER_1 to $CONTAINER_2 is successful."
else
  echo "Ping from $CONTAINER_1 to $CONTAINER_2 failed."
  exit 1
fi

# Check ping from Container 2 to Container 1

if docker exec $CONTAINER_2 ping -c 3 $CONTAINER_1 >/dev/null; then
  echo "Ping from $CONTAINER_2 to $CONTAINER_1 is successful."
else
  echo "Ping from $CONTAINER_2 to $CONTAINER_1 failed."
  exit 1
fi

