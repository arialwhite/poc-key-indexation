#!/bin/bash

# docker-compose env
export COMPOSE_PROJECT_NAME='indexer'

if [[ -n "$CLEAN_UNSAFE" ]]; then
  docker-compose down
  docker rm -v $(docker ps -a -q -f status=exited)
  docker volume rm $(docker volume ls -q -f dangling=true)
fi

rm -rf ./volumes/cassandra
rm -rf ./volumes/kafka
rm -rf ./volumes/zookeeper
rm -rf ./volumes/spark/data
rm -rf ./volumes/frontend/local/node_modules
rm -rf ./volumes/frontend/global/node_modules

if [[ -n "$CLEAN_UNSAFE" ]]; then
  USER='julian'
  chown -R $USER:$USER ./volumes
fi