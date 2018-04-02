# POC indexation - Kafka/Spark/Cassandra 

A proof of concept project, the idea is to launch a small cluster with a single command

## Overview

### Services

- Kafka
- Zookeeper
- Rest-proxy
- Schema-registry
- Spark
- Cassandra
- backend (Spring Boot)
- frontend (Angular 5)

### Flow

INPUT -> Kafka -> Spark Streaming -> Cassandra -> OUTPUT

## Installation

- Install Docker and docker-compose, see https://docs.docker.com/compose/install/

- Clone all git repositories at once
```
git clone  --recursive https://github.com/arialwhite/poc-key-indexation.git
```

- Run start.sh
```
chmod u+x ./start.sh
sudo ./start.sh
```

## Usage

- Go to http://localhost:4200

## Documentation

- http://docs.confluent.io/current/cp-docker-images/docs/quickstart.html#getting-started-with-docker-compose


