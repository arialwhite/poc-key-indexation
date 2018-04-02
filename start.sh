#!/bin/bash

export NO_PROXY="/var/run/docker.sock"

if ! [[ -f './volumes/shared/poc-key-indexation_spark-streaming/target/scala-2.11/Streaming Project-assembly-1.0.jar' ]]; then
  echo 'build spark project..'
  sleep 1
  docker run -t --rm -v "$PWD/volumes/shared/poc-key-indexation_spark-streaming:/opt/docker-project" -w /opt/docker-project hseeberger/scala-sbt sbt assembly
fi

echo create directories
mkdir -p ./volumes/cassandra
mkdir -p ./volumes/kafka/data
mkdir -p ./volumes/zookeeper/{data,log}
mkdir -p ./volumes/spark/data/{master,worker}
mkdir -p ./volumes/producer/repository

TOPIC_NAME='small_topic'

# docker-compose env
export COMPOSE_PROJECT_NAME='indexer'

# get kafka container id
KAFKA_CONT=$(docker ps -q -f name="${COMPOSE_PROJECT_NAME}_kafka")

# launch docker-compose if needed
if [[ -z "$KAFKA_CONT" ]]; then
  echo "docker-compose up.."
  docker-compose up -d
  echo "wait 4s.."
  sleep 4
fi

# ------------------------
# KAFKA
# ------------------------
# create kafka topic
echo "create ${TOPIC_NAME}"
docker exec indexer_kafka_1 kafka-topics --create --topic "$TOPIC_NAME" --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181

# ------------------------
# SPARK
# ------------------------

# submit spark job
echo 'submit job to spark..'
docker exec indexer_spark-master_1 spark-submit --class "StreamApp" --master local[4] '/opt/docker-shared/poc-key-indexation_spark-streaming/target/scala-2.11/Streaming Project-assembly-1.0.jar' &

# ------------------------
# KAFKA
# ------------------------

# produce welcome message
echo "produce some data on ${TOPIC_NAME}.."
docker exec indexer_kafka_1 bash -c "echo 'black:white' | kafka-console-producer --broker-list localhost:29092 --topic $TOPIC_NAME --property 'key.separator=:' -property 'parse.key=true'"

